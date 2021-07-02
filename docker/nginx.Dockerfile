FROM nginx:1.21.0

RUN openssl req -x509 -nodes -days 365 \
        -subj "/C=CA/ST=QC/O=Foo, Bar." -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out /etc/ssl/certs/nginx-selfsigned.crt;

RUN openssl rsa -in /etc/ssl/private/nginx-selfsigned.key -text > /etc/ssl/certs/nginx-selfsigned.pem

