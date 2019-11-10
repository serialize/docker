FROM nginx:alpine
ADD assets/sites-enabled/ /etc/nginx/sites-enabled
COPY assets/nginx.conf /etc/nginx/nginx.conf
ADD assets/server.crt /etc/nginx/ssl/
ADD assets/server.key /etc/nginx/ssl/
