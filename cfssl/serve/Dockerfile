FROM serialize/cfssl:base

USER root

COPY ./entrypoint.sh /entrypoint

RUN mkdir -p /usr/local/share/cfssl \
    && chown cfssl /usr/local/share/cfssl

COPY ./sqlite-create.sql /usr/local/share/cfssl/sqlite-create.sql

USER cfssl

ENTRYPOINT [ "/entrypoint" ]

CMD [ "serve" ]
