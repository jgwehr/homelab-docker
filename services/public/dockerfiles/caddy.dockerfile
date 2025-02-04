ARG CADDY_VERSION=2.9.1

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/duckdns \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http

FROM caddy:${CADDY_VERSION} AS caddy

WORKDIR /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
