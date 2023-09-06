## Included projects

- https://github.com/pi-hole/pi-hole
- https://github.com/MatthewVance/unbound-docker

## Dependencies

- My Pi-hole setup depends on Unbound for DNS resolution. However, this isn't required. You can choose to use any other DNS service instead. Remove or update `PIHOLE_DNS_`. If removed, modify via UI.


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
- I've had really good luck with Orbital Sync when running 2+ Pi-Holes

- `PIHOLE_PASSWORD` - Generate a password with something like `openssl rand -base64 32`. Used to login to the UI.
- `FTLCONF_LOCAL_IPV4` - Most likely your local host ip, same as `SERVER_URL` 
- `PIHOLE_DHCP_ACTIVE` - I don't use the DHCP functionality, please refer to Pi-hole documentation if you want to use this.
- `PIHOLE_DOMAIN` - Not super useful unless you use DHCP
- `TEMPERATUREUNIT`
- `PIHOLE_WEBTHEME`


### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)

## Backups
- Use Pi-hole's Teleport feature