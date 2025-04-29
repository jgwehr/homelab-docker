## Included projects

- https://github.com/pi-hole/pi-hole
- https://github.com/MatthewVance/unbound-docker
- https://github.com/lovelaze/nebula-sync

## Dependencies

- My Pi-hole setup depends on Unbound for DNS resolution. However, this isn't required. You can choose to use any other DNS service instead. Follow Pi-Hole's instructions. But, generally, this means removing `FTLCONF_dns_revServers` and configuring `FTLCONF_dns_upstreams`


## Environment and Configuration

### Files
1. Copy `./configtemplates/pihole/resolv.conf` to your config directory for pihole `${CONFIGDIR}/pihole/resolv.conf`
1. Copy all files in `./configtemplates/unbound` to your config directory for unbound `${CONFIGDIR}/unbound`



### Ports
- `PORT_PIHOLE_WEB`
- `PORT_PIHOLE_WEBSSL`
- `PORT_PIHOLE_TCP`
- `PORT_PIHOLE_UDP`


### URLs
- `SERVER_URL` - universal. your internal url

### Functionality

- `PIHOLE_PASSWORD` - Used for both accessing the Pi-Hole web UI but behind the scenes for Nebula Sync.
- `PIHOLE_DHCP_ACTIVE` - I don't use the DHCP functionality, please refer to Pi-hole documentation if you want to use this.
- `PIHOLE_DOMAIN` - Not super useful unless you use DHCP
- `PIHOLE_WEBTHEME`

#### Nebula Sync
This is only needed if you're running two or more Pi-Holes. And, it's only needed on a single host. It's goal is to sync settings across all targeted Pi-Holes.


### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)

## Backups
- Use Pi-hole's Teleport feature
- Alternatively, my backup.sh script will copy the entire config directory. The Gravity and FTL files are deleted to save space since they're emphemeral anyway'.