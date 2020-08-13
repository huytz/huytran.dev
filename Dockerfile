FROM nginx

ADD default.conf /etc/nginx/conf.d/

COPY public /var/www/huytran.dev