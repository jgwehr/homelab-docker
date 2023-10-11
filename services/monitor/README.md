## Included projects

- https://github.com/amir20/dozzle
- https://github.com/crazy-max/diun
- https://github.com/AnalogJ/scrutiny
- https://github.com/alexjustesen/speedtest-tracker
- https://github.com/louislam/uptime-kuma

## Dependencies

- Hard dependency on the **infra** service stack, which provides the Docker Socket Proxy
- You may which to provide some apps externally, especially Uptime Kuma. Public access via Reverse Proxy requires the **public** Service and Network

## Environment and Configuration

### Files
n/a

### Ports

- `PORT_SOCKY_PROXY` - defined as part of **infra**
- `PORT_DOZZLE`
- `PORT_SPEEDTEST`
- `PORT_UPKUMA`
- `PORT_SCRUTINY`
- `PORT_SCRUTINY_DB`

### URLs
- `EXTERNAL_RALLLY` - how the app is exposed via Reverse Proxy to the public. You must also update the Caddyfile to match.
- `SERVER_URL` - universal. your internal url
- `DOMAIN` - universal. your public facing domain name

### Functionality
- `HOST_NAME` - Universal. Helps orient you within Dozzle

- `DIUN_NOTIF_DISCORD_WEBHOOKURL` - Refer to Diun's instructions. I use Discord
- `${STATICCONFIGDIR}/diun/diun.yml` - Refer to Diun's instructions. You may need to edit this file for your needs.



### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)
- `STATICCONFIGDIR`
- `DBDIR` - universal. where databases store their... databases. 

### Local Only
- Remove/Comment the Caddy-net Network
- Remove/Comment references to `EXTERNAL_RALLLY`, `DOMAIN`

## Backups
- If needed, standard backup of CONFIGDIR