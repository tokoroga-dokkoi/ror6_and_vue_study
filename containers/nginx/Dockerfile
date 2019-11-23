# nginx
FROM nginx:latest 

COPY ./public-data/app/dist/* /var/www/html

RUN rm -f /etc/nginx/conf.d/*

ADD nginx.conf /etc/nginx/conf.d/webapp.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf