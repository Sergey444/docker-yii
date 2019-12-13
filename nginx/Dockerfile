FROM nginx

RUN apt update && apt install -y openssl

COPY ./default.conf /etc/nginx/conf.d/
COPY ./nginx.conf /etc/nginx/

COPY example.local.crt /usr/local/share/ca-certificates/
COPY example.local.key /usr/local/share/ca-certificates/

# change uid for nginx user to avoid problems with host permissions
ARG HOST_USER_ID
ARG HOST_GROUP_ID
RUN groupadd -g $HOST_GROUP_ID user && useradd -d /var/www/docker/user -s /bin/bash -u $HOST_USER_ID -g $HOST_GROUP_ID user

WORKDIR /var/www
