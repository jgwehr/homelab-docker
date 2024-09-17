FROM alpine:latest

RUN apk update
RUN apk add --no-cache curl bash

ENV QBITTORRENT_SERVER=localhost
ENV QBITTORRENT_PORT=8080
ENV QBITTORRENT_USER=admin
ENV QBITTORRENT_PASS=adminadmin
ENV QBITTORRENT_SECURE=http

ENV GLUETUN_HOST=localhost
ENV GLUETUN_PORT=8000
ENV GLUETUN_SECURE=http

ENV PORT_FORWARDED=
ENV RECHECK_TIME=60


COPY ./port_manager.sh ./port_manager.sh
RUN chmod 770 ./port_manager.sh

CMD ["./port_manager.sh"]