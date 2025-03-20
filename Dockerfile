FROM nginx:1-alpine-slim
COPY . /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
EXPOSE 80
