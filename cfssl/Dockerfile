FROM golang:alpine as build-env

RUN apk add --no-cache --virtual .build-deps \
        build-base \
        gcc \
        git \
        libtool \
        sqlite-dev \
    && apk add --no-cache \
        curl \
        python \
    && mkdir -p /cfssl-bin

RUN git clone --depth=1 "https://github.com/cloudflare/cfssl.git" "${GOPATH}/src/github.com/cloudflare/cfssl" \
    && cd "${GOPATH}/src/github.com/cloudflare/cfssl" \
	&& go build -o /cfssl-bin/cfssl ./cmd/cfssl \
	&& go build -o /cfssl-bin/cfssljson ./cmd/cfssljson \
	&& go build -o /cfssl-bin/mkbundle ./cmd/mkbundle \
	&& go build -o /cfssl-bin/multirootca ./cmd/multirootca \
	&& apk del .build-deps \
	&& rm -rf "${GOPATH}/src"

VOLUME /cfssl-bin


FROM alpine:3.10

COPY ./assets/entrypoint /
COPY ./assets/*.json /usr/local/share/cfssl/
COPY ./assets/*.conf /usr/local/share/cfssl/
COPY --from=build-env /cfssl-bin /usr/bin

RUN addgroup -S cfssl \
    && adduser -S -g cfssl cfssl \
	&& mkdir -p /etc/cfssl \
    && chown -R cfssl:cfssl /etc/cfssl /usr/local/share/cfssl /entrypoint \
    && chmod 770 /etc/cfssl /usr/local/share/cfssl /entrypoint \
    && chown cfssl:cfssl /usr/bin/cfssl /usr/bin/cfssljson /usr/bin/mkbundle /usr/bin/multirootca \
    && chmod 770 /usr/bin/cfssl /usr/bin/cfssljson /usr/bin/mkbundle /usr/bin/multirootca

USER cfssl

WORKDIR /etc/cfssl

VOLUME [ "/etc/cfssl" ]
EXPOSE 8888

ENTRYPOINT [ "/entrypoint" ]

CMD [ "cfssl", "serve" ]
