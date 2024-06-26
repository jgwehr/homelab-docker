FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/duckdns \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http

FROM caddy:2.8.4

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

