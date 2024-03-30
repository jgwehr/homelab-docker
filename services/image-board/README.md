## Included projects

- https://github.com/pinry/pinry

## Dependencies


## Environment and Configuration

### Files

### Ports
- `PORT_PINRY`

### URLs
All of these are only available LOCALLY. For any remote "requests" I use Jellyseerr
- `DOMAIN` - universal. your public facing domain name
- `EXTERNAL_PINRY` - how the app is exposed via Reverse Proxy to the public. You must also update the Caddyfile to match.

### Functionality
- `PINRY_SECRETKEY` - Generate a password with something like `openssl rand -base64 32`.

### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)


## Backups
1. Image etc are stored in `CONFIGDIR`