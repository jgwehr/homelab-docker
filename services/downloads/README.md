## Included projects

- https://github.com/Radarr/Radarr
- https://github.com/Sonarr/Sonarr
- https://github.com/Prowlarr/Prowlarr
- https://github.com/qdm12/gluetun
- https://github.com/akhilrex/podgrab


See: https://github.com/jgwehr/homelab-docker/wiki/*Arr-Configuration

## Dependencies

- All *arr and related apps run under the Gluetun container's VPN connection. Gluetun must be active and connected to the VPN for any of these to work.
- In order for Gluetun to work, you must have a compatible VPN provider.


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


### Ports

- `PORT_GLUETUN_CONTROL` - API Access for things like Homepage (and the Gluetun Port Manager) 
- `PORT_TORRENT_UI`
- `PORT_PROWLARR_UI`
- `PORT_SONARR_UI`
- `PORT_RADARR_UI`

### URLs
All of these are only available LOCALLY. For any remote "requests" I use Jellyseerr
- `DOMAIN` - universal. your public facing domain name
- `SERVER_URL` - universal. your public facing domain name
- `PORT_GLUETUN_CONTROL` - provides API access
- `PORT_PROWLARR_UI` - provides web access
- `PORT_TORRENT_UI` - provides web access
- `PORT_RADARR_UI` - provides web access
- `PORT_SONARR_UI` - provides web access
- `PORT_PODGRAB` - provides web access

### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)
- `MEDIADIR` - universal. where media files (including downloads) are organized


## Backups
1. *arr apps do a wonderful job creating backups of themselves. Configure each per their instructions.  The files are then available in your CONFIG dir under `*arr/Backups/scheduled/`