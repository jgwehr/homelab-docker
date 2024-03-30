## Included projects

- https://github.com/jellyfin

## Dependencies

- I highly recommend an Intel CPU with QuickSync. While not required, it's the cheapest path to high performance for 4k streaming. I have an i3-12100 that works wonderfully.
- **Depending on how or if you use Hardware Acceleration may change how your *docker-compose* should look. Configuring Hardware Acceleration is an advanced topic. Follow Jellyfin's instructions. My steps are here: https://github.com/jgwehr/homelab-docker/wiki/*Arr-Configuration#jellyseer. 


## Environment and Configuration

### Files

### Ports
- `PORT_HTPC_HTTP`
- `PORT_HTPC_HTTPS`
- `PORT_HTPC_LOCAL` - for local discovery
- `PORT_HTPC_DLNA` - for DLNA


### URLs
- `SERVER_URL` - universal. your internal url

### Functionality
- `GID_HARDWAREACC` - The core OS GroupId for video rendering
- `HOMEPAGE_JELLYFIN_API`


### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)

## Backups
- Use Pi-hole's Teleport feature
- Alternatively, my backup.sh script will copy the entire config directory. The Gravity and FTL files are deleted to save space since they're emphemeral anyway'.