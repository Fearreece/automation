FROM nginx:1-alpine-slim
COPY . /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /usr/share/nginx/html
USER appuser
EXPOSE 80
