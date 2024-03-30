## Included projects

- https://github.com/Fallenbagel/jellyseerr

## Dependencies

- I don't think you necessarily *need* Jellyfin but it obviously improves the experience dramatically. And provides the quickest Authentication configuration.
- 


## Environment and Configuration

### Files
1. Copy `./configtemplates/pihole/resolv.conf` to your config directory for pihole `${CONFIGDIR}/pihole/resolv.conf`
1. Copy all files in `./configtemplates/unbound` to your config directory for unbound `${CONFIGDIR}/unbound`



### Ports
- `PORT_HTPC_REQUESTS`


### URLs
- `SERVER_URL` - universal. your internal url

### Functionality
- I've had really good luck with Orbital Sync when running 2+ Pi-Holes

- `HOMEPAGE_JELLYSEERR_API` - from System Settings > General


### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)

## Backups