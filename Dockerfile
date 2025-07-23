#################################
#   Multi Stage Docker Server   #
#################################

# ----- Builder -----
FROM hugomods/hugo:debian-reg-dart-sass-git-0.148.1 AS builder

# Set working directory
WORKDIR /src

# Build files
COPY . .

# If using Hugo modules, ensure Go modules are downloaded
RUN hugo mod download

# Debug: List files before build
RUN ls -la

# Run Hugo build and verify output
RUN hugo -E -F --minify -d public && \
    echo "Build completed, checking output:" && \
    ls -la public/

# ----- Server -----
FROM nginx:alpine

# Serve files
COPY ./docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /src/public /usr/share/nginx/html

# Verify files were copied
RUN ls -la /usr/share/nginx/html/

EXPOSE 80