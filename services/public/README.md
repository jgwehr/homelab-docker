## Included projects

- https://github.com/caddyserver/caddy
- https://github.com/caddy-dns/duckdns
- https://github.com/hslatman/caddy-crowdsec-bouncer/http
- https://www.duckdns.org/
- https://ghcr.io/linuxserver/duckdns


## Dependencies
- If you use DuckDNS, consider donating to them. 

## Environment and Configuration

### Files


### Ports

- `PORT_CADDY_HTTP`
- `PORT_CADDY_HTTPS`
- `PORT_CADDY_ADMIN` - Only for fun stats via API in Homepage

### URLs
- `SERVER_URL` - universal. your internal url
- `DOMAIN` - universal. your public facing domain name

### Functionality
- `EMAIL_ADMIN` - Required for automatic SSL renewal
- **Caddyfile** - `./staticconfig/caddy/Caddyfile` this is where the magic happens. Refer to Caddy's documentation. Very important to update Ports in this file to match `.env`. 


### Secrets
- `DUCKDNS_TOKEN` - Allows SSL renewal through DUCKDNS via https://github.com/caddy-dns/duckdns
- `DUCKDNS_SUBDOMAINLIST` - Any of the subdomains you have via DuckDNS you want refreshed with this server's IP

### Databases


### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)
- `LOGDIR` - universal. where the containers store their log data
- `STATICDIR` - uploaded documents go here


## Backups
