FROM postgres:9.6.15

ENV GOSU_VERSION 1.10

ADD ./gosu /usr/bin/
RUN chmod +x /usr/bin/gosu

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

VOLUME /var/lib/postgresql
VOLUME /var/lib/postgresql/data

EXPOSE 5432

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "gosu", "postgres", "postgres" ]
