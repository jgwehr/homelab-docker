A personal project as I start to learn how to run a Homelab. 

![GitHub last commit](https://img.shields.io/github/last-commit/jgwehr/homelab-docker)

Includes: 
- Learning Docker, Docker Compose
- Self-Hosting for Privacy, such as: BitWarden, PiHole, Unbound, Wireguard
- Self-Hosting for Entertainment, such as: Plex, Gloomhaven Campaign & Tracker, RetroPi
- Self-Hosting for Small Business, such as: Akaunting, Tabby
- Self-Hosting for Friends, such as: SheetAble, Minecraft


### Port Reservations
* Organizr: 81
* Portainer Management UI: 9000
* Portainer Management UI: 8001
* Uptime-Kuma: 9001


## Optionals
### Caddy and DuckDns.org
- If you do not use DuckDns.org and/or use another provider which needs a Caddy DNS module, alter `dockerfiles/caddy.dockerfile` appropriately
- You can choose to alter docker-compose to point to [snoopeppers/caddy-duckdns](https://hub.docker.com/repository/docker/snoopeppers/caddy-duckdns) instead of having it build the image itself (though, naturally building it yourself will be more stable)
- If you choose to handle Caddy in someother way (eg. don't containerize it) or do not need additional modules, I'd recommend
  - deleting `dockerfiles/caddy.dockerfile`
  - altering docker-compose as required
