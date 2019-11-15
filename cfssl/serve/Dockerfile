FROM serialize/cfssl:base

USER root

COPY ./entrypoint.sh /

RUN chown -R cfssl:cfssl /entrypoint.sh \
    && chmod -R 770 /entrypoint.sh 

USER cfssl

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "cfssl", "serve" ]
