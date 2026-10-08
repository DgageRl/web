FROM nginx:alpine

# Копируем статику (будет передана через volume)
COPY ./src /usr/share/nginx/html

# Внутренний конфиг (простой)
RUN echo 'server { listen 80; root /usr/share/nginx/html; index index.html; location / { try_files $uri $uri/ =404; } }' \
    > /etc/nginx/conf.d/default.conf

EXPOSE 80