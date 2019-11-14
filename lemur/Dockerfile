FROM python:3.7-alpine

ARG VERSION
ENV VERSION master

ENV uid 1000
ENV gid 1000
ENV user lemur
ENV group lemur

ENV LEMUR_CONF /etc/lemur/lemur.conf.py

RUN apk --update add \
        python3 \
        libldap \
        postgresql-client \
        curl \
        tzdata \
        openssl \
        bash && \
    apk --update add --virtual build-dependencies \
        git \
        tar \
        curl \
        python3-dev \
        npm \
        bash \
        musl-dev \
        gcc \
        autoconf \
        automake \
        make \
        nasm  \
        zlib-dev \
        postgresql-dev \
        libressl-dev  \
        libffi-dev \
        cyrus-sasl-dev \
        openldap-dev && \
        addgroup -S ${group} -g ${gid} && \
        adduser -D -S ${user} -G ${group} -u ${uid} && \
        mkdir -p /opt/lemur /etc/lemur /var/log/lemur /home/lemur/.lemur/ 

COPY ./entrypoint.sh /
COPY ./lemur.conf.py $LEMUR_CONF

RUN curl -sSL https://github.com/Netflix/lemur/archive/$VERSION.tar.gz | tar xz -C /opt/lemur --strip-components=1 && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade setuptools && \
    chmod +x /entrypoint && \
    chown -R $user:$group /opt/lemur/ /etc/lemur/ /var/log/lemur/ /home/lemur/.lemur/

WORKDIR /opt/lemur

RUN sed -i 's/localhost/pki_manager_api/g' /opt/lemur/gulp/server.js && \
    npm install --unsafe-perm && \
    pip3 install -e . && \
    node_modules/.bin/gulp build && \
    node_modules/.bin/gulp package --urlContextPath=$(urlContextPath) && \
    apk del build-dependencies

VOLUME [ "/opt/lemur/lemur/static/dist", "/var/log/lemur", "/etc/lemur" ]

USER lemur

ENTRYPOINT [ "/entrypoint" ]

CMD [ "lemur", "start", "-b", "0.0.0.0:8000" ]
