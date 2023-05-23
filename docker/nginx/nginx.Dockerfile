FROM nginx:1.23.4-bullseye

RUN apt update && apt install vim -y

RUN rm -rf /etc/nginx/nginx.conf
COPY ./docker/nginx/conf/nginx.conf /etc/nginx/nginx.conf

WORKDIR /app/public
COPY ./public /app/public

CMD [ "nginx", "-g", "daemon off;" ]

EXPOSE 80 443
