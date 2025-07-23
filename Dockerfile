#################################
#   Multi Stage Docker Server   #
#################################

# ----- Builder -----
FROM hugomods/hugo:debian-reg-dart-sass-git-0.148.1 as builder

# Build files
COPY . .
RUN  hugo -E -F --minify -d public


# ----- Server -----
FROM nginx:alpine

# Serve files
COPY ./docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder ./public /usr/share/nginx/html
EXPOSE 80