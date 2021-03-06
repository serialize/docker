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
    && go get github.com/GeertJohan/go.rice/rice && rice embed-go -i=./cli/serve \
	&& go build -o /cfssl-bin/cfssl ./cmd/cfssl \
	&& go build -o /cfssl-bin/cfssljson ./cmd/cfssljson \
	&& go build -o /cfssl-bin/mkbundle ./cmd/mkbundle \
	&& go build -o /cfssl-bin/multirootca ./cmd/multirootca \
	&& apk del .build-deps \
	&& rm -rf "${GOPATH}/src"

VOLUME /cfssl-bin


FROM alpine:3.10

COPY --from=build-env /cfssl-bin /usr/bin

COPY cfssl-serve.sh /usr/bin/cfssl-serve

RUN apk add --no-cache bash curl sqlite \
    && addgroup -S cfssl \
    && adduser -S -g cfssl cfssl \
	&& mkdir -p /etc/cfssl /etc/certs \
    && chown -R cfssl:cfssl \
                /etc/cfssl \
                /etc/certs \
                /usr/bin/cfssl \
                /usr/bin/cfssljson \
                /usr/bin/mkbundle \
                /usr/bin/multirootca \
    && chmod -R 770 \
                /etc/cfssl \
                /etc/certs \
                /usr/bin/cfssl \
                /usr/bin/cfssljson \
                /usr/bin/mkbundle \
                /usr/bin/multirootca

USER cfssl

WORKDIR /etc/cfssl

VOLUME [ "/etc/cfssl", "/etc/certs" ]

ENTRYPOINT [ "cfssl" ]

CMD [ "--help" ]
