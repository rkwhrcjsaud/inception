FROM debian:bullseye

ARG	CERT_DIR
ARG	CERTIFICATE
ARG	KEY
ARG	COUNTRY
ARG	STATE
ARG	LOCALITY
ARG	ORGANIZATION
ARG	UNIT
ARG	DOMAIN_NAME

RUN apt update -y && apt upgrade -y
RUN apt install nginx curl openssl -y
RUN mkdir -p ${CERT_DIR} && \
	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out ${CERTIFICATE} \
    -keyout ${KEY} \
    -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${UNIT}/CN=${DOMAIN_NAME}"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /run/nginx

RUN sed -i "s#{{CERTIFICATE}}#$CERTIFICATE#g" /etc/nginx/nginx.conf
RUN sed -i "s#{{KEY}}#$KEY#g" /etc/nginx/nginx.conf
RUN sed -i "s#{{DOMAIN_NAME}}#$DOMAIN_NAME#g" /etc/nginx/nginx.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
