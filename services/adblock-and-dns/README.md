## Included projects

- https://github.com/pi-hole/pi-hole
- https://github.com/MatthewVance/unbound-docker
- https://github.com/lovelaze/nebula-sync

## Dependencies

- My Pi-hole setup depends on Unbound for DNS resolution. However, this isn't required. You can choose to use any other DNS service instead. Follow Pi-Hole's instructions. But, generally, this means changing `FTLCONF_dns_upstreams`


## Environment and Configuration
*See this excellent guide/repo: https://github.com/kaczmar2/pihole-unbound/blob/main/README.md*

### Execute Commands

```shell
sudo mkdir -p /srv/docker/pihole-unbound/pihole/etc-pihole
sudo mkdir -p /srv/docker/pihole-unbound/pihole/etc-dnsmasq.d
sudo mkdir -p /srv/docker/pihole-unbound/unbound/etc-unbound
sudo mkdir -p /srv/docker/pihole-unbound/unbound/unbound.conf.d

touch /srv/docker/pihole-unbound/unbound/etc-unbound/unbound.log

chown -R $USER:docker /srv/docker/pihole-unbound
chmod -R 755 /srv/docker/pihole-unbound
```

### Files
#### Unbound
1. Copy `./configtemplates/unbound/unbound.conf` to your config directory for unbound `${CONFIGDIR}/pihole-unbound/unbound` (eg. **/srv/docker/pihole-unbound/unbound/unbound.conf**)
1. Copy `./configtemplates/unbound/unbound.conf.d` to your config directory for unbound `${CONFIGDIR}/pihole-unbound/unbound` (eg. **/srv/docker/pihole-unbound/unbound/unbound.conf.d**)



### Ports
- `PORT_PIHOLE_WEB`
- `PORT_PIHOLE_WEBSSL`
- `PORT_PIHOLE_TCP`
- `PORT_PIHOLE_UDP`


### URLs
- `SERVER_URL` - universal. your internal url

### Functionality

- `PIHOLE_PASSWORD` - Used for both accessing the Pi-Hole web UI and behind the scenes for Nebula Sync / Homepage.
- `PIHOLE_DHCP_ACTIVE` - I don't use the DHCP functionality, please refer to Pi-hole documentation if you want to use this.
- `PIHOLE_DOMAIN` - Not super useful unless you use DHCP
- `PIHOLE_WEBTHEME`
- `PIHOLE_NTP_IPV4_ACTIVE` and `PIHOLE_NTP_IPV6_ACTIVE` - Set to false to avoid using pihole as a NTP (system time) Server

#### Nebula Sync
This is only needed if you're running two or more Pi-Holes. And, it's only needed on a single host. It's goal is to sync settings across all targeted Pi-Holes.

### Test Functionality
1. Test Unbound is operational: within the container, execute `dig pi-hole.net @127.0.0.1 -p 5053`
1. Then, test for a **failed** response: `dig fail01.dnssec.works @127.0.0.1 -p 5053`
1. Then, test for a **success** response: `dig dnssec.works @127.0.0.1 -p 5053`

### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)

## Backups
- Use Pi-hole's Teleport feature
- Alternatively, my backup.sh script will copy the entire config directory. The Gravity and FTL files are deleted to save space since they're emphemeral anyway'.