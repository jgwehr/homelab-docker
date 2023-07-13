## Included projects

- https://github.com/Lurkars/gloomhavensecretariat
- https://github.com/Lurkars/ghs-server

## Dependencies

- These services can run locally. Various Networks and dependencies can be removed if you only want local access.
- Public access via Reverse Proxy requires the `public` Service and Network


## Environment and Configuration

### Files
`services\gloomhaven\configtemplates\ghs\application.properties` should be copied to your configuration volume (`${CONFIGDIR}`/ghs). The GHS Server mounts this file for additional configuration.

### Ports

- `PORT_GHS_CLIENT`
- `PORT_GHS_SERVER`

### URLs
- `EXTERNAL_GHS` - how the client is exposed via Reverse Proxy to the public. You must also update the Caddyfile to match.
- `SERVER_URL` - universal. your internal url
- `DOMAIN` - universal. your public facing domain name

### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)

### Local Only
- Remove/Comment the Caddy-net Network
- Remove/Comment references to `EXTERNAL_GHS`, `DOMAIN`

## Backups