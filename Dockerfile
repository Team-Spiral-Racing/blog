#################################
#   Multi Stage Docker Server   #
#################################

# ----- Builder -----
FROM hugomods/hugo:debian-reg-dart-sass-git-0.148.1 AS builder

# Set working directory
WORKDIR /src

# Copy all files including .gitmodules if it exists
COPY . .

# Install theme - this handles multiple scenarios:
# 1. If .gitmodules exists, initialize submodules
# 2. If no theme exists, download it manually
RUN if [ -f .gitmodules ]; then \
        echo "Found .gitmodules, initializing submodules..." && \
        git submodule update --init --recursive; \
    elif [ ! -d themes/blowfish ]; then \
        echo "No theme found, downloading Blowfish theme..." && \
        git init && \
        git submodule add -b main https://github.com/nunocoracao/blowfish.git themes/blowfish; \
    else \
        echo "Theme directory already exists"; \
    fi

# Debug: Verify theme is available
RUN ls -la themes/ && \
    if [ -d themes/blowfish ]; then \
        echo "✓ Blowfish theme found"; \
        ls -la themes/blowfish/ | head -10; \
    else \
        echo "✗ Blowfish theme missing" && exit 1; \
    fi

# Run Hugo build
RUN hugo -E -F --minify -d public && \
    echo "Build completed successfully!" && \
    ls -la public/ && \
    echo "Generated files:" && \
    find public/ -type f | head -10

# ----- Server -----
FROM nginx:alpine

# Copy custom nginx config
COPY ./docker/nginx.conf /etc/nginx/conf.d/default.conf

# Copy generated site
COPY --from=builder /src/public /usr/share/nginx/html

# Verify deployment
RUN ls -la /usr/share/nginx/html/ && \
    echo "Deployment successful!"

EXPOSE 80