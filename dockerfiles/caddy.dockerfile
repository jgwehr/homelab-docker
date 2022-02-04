FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/duckdns \
    --with github.com/hslatman/caddy-crowdsec-bouncer

FROM caddy:2.4.6

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

