## Included projects

- https://github.com/Radarr/Radarr
- https://github.com/Sonarr/Sonarr
- https://github.com/Prowlarr/Prowlarr
- https://github.com/qdm12/gluetun
- https://github.com/akhilrex/podgrab
- https://github.com/alexta69/metube

See: https://github.com/jgwehr/homelab-docker/wiki/*Arr-Configuration

## Dependencies

- All *arr and related apps run under the Gluetun container's VPN connection. Gluetun must be active and connected to the VPN for any of these to work.
- In order for Gluetun to work, you must have a compatible VPN provider.
- Metube is an exception; it has no dependencies. There might be a usecase for it to need a VPN - but it's not a requirement for me.


## Environment and Configuration
I highly recommend TRaSH Guides for setting up these services https://trash-guides.info/

### Files

### Gluetun VPN
Follow Gluetun's instructions. In my case, I must provide:
- `VPN_SERVICE_PROVIDER`
- `VPN_USER`
- `VPN_PASSWORD`
- `VPN_HOSTNAMES`

The custom image "gluetun_port_manager" is a simple shell script meant to request the forwarded port from Gluetun (provided by your VPN) and set it as the `Listening Port` within qBittorrent. This is only needed if your VPN randomizes the forwarding port for P2P traffic. It may not perfectly capture all errors or situations. Your mileage may vary. 

- `GLUETUN_APIKEY` This you must generate and save to a file your config directory. see: https://github.com/gethomepage/homepage/discussions/5344. Create a key, pasting it into `${CONFIGDIR}/gluetun/config.toml` with the format given above. That same key goes into .env


### MeTube
There are quite a lot of interesting config options: https://github.com/alexta69/metube
I don't use these, but there are options to help with downloading private/restricted videos, better organization, etc.

### Ports

- `PORT_GLUETUN_CONTROL` - API Access for things like Homepage (and the Gluetun Port Manager) 
- `PORT_TORRENT_UI`
- `PORT_TORRENT_TCP`
- `PORT_TORRENT_UDP`
- `PORT_PODGRAB`
- `PORT_PROWLARR_UI`
- `PORT_SONARR_UI`
- `PORT_RADARR_UI`
- `PORT_YOUTUBE`

### URLs
All of these are only available LOCALLY. For any remote "requests" I use Jellyseerr
- `DOMAIN` - universal. your public facing domain name
- `SERVER_URL` - universal. your public facing domain name

### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)
- `MEDIADIR` - universal. where media files (including downloads) are organized
- `DOWNLOADDIR` universal. Some apps will create content here and move/link to `MEDIADIR`. This isn't required. It's up to you (and the apps themselves) how sub directories are organized. For example, Podgrab will always go straight to `MEDIADIR` because it will only ever manage Podcasts. Metube's first stop is `DOWNLOADDIR`, though, as it can create different *kinds* of media. The *arr stack uses `DOWNLOADDIR` for different reasons: integration with qBittorrent *and* library management.


## Backups
1. *arr apps do a wonderful job creating backups of themselves. Configure each per their instructions.  The files are then available in your CONFIG dir under `*arr/Backups/scheduled/`