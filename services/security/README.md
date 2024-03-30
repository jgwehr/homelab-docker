## Included projects

- https://www.crowdsec.net/
- https://ghcr.io/linuxserver/endlessh

## Dependencies

- My Pi-hole setup depends on Unbound for DNS resolution. However, this isn't required. You can choose to use any other DNS service instead. Remove or update `PIHOLE_DNS_`. If removed, modify via UI.
- These tools assist the **public** stack. If you're not exposing your server externally, you probably don't need them. 


## Environment and Configuration

### Files
1. Copy `./staticconfig/crowdsec/acquis.yaml` to your config directory for CrowdSec `${CONFIGDIR}/crowdsec/acquis.yaml`



### Ports
- `PORT_CROWDSEC_API` - exposes a REST API for bouncers, cscli and communication between crowdsec agent and local api
- `PORT_CROWDSEC_METRICS` - exposes prometheus metrics on /metrics and pprof debugging metrics on /debug
- `PORT_SOCKY_PROXY` - defined as part of **infra**
- `PORT_SSHPROTECT` - more than likely 22. You will want to follow SSH hardening steps (https://github.com/jgwehr/homelab-docker/wiki/Hardware-Install#harden-ssh)

### URLs

### Functionality
- `ESSH_MSDELAY` - Refer to Endhlessh documentation
- `ESSH_MAXLINES` - Refer to Endhlessh documentation
- `ESSH_MAXCLIENTS` - Refer to Endhlessh documentation
- `ESSH_BINDFAMILY` - Refer to Endhlessh documentation


### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)

## Backups
- Use Pi-hole's Teleport feature
- Alternatively, my backup.sh script will copy the entire config directory. The Gravity and FTL files are deleted to save space since they're emphemeral anyway'.