A personal project as I start to learn how to run a Homelab. 

![GitHub last commit](https://img.shields.io/github/last-commit/jgwehr/homelab-docker)

Includes: 
- Learning Docker, Docker Compose
- Self-Hosting for Privacy, such as: BitWarden, PiHole, Unbound, Wireguard
- Self-Hosting for Entertainment, such as: Plex, Gloomhaven Campaign & Tracker, RetroPi
- Self-Hosting for Small Business, such as: Akaunting, Tabby
- Self-Hosting for Friends, such as: SheetAble, Minecraft

# Technology
`control-server`
![Watchtower](https://github.com/NX211/homer-icons/blob/master/png/watchtower.png)
![Portainer]https://github.com/NX211/homer-icons/blob/master/png/portainer.png)
Uptime Kuma

`navigation-server`
![Heimdall](https://github.com/NX211/homer-icons/blob/master/png/heimdall.png)

`network-server`
Caddy

`vault-server`
![Vaultwarden](https://github.com/NX211/homer-icons/blob/master/png/bitwarden.png)



# Project Structure
I can't find any good practices for this. So here's where it's currently at.

## File System
### Docker Compose (and needed files)
`~/home/{$USER}/docker`

This github repo represents this folder. It's safely shared with the public and shouldn't contain anything sensitive.

Individual contexts are their own folders. This allows separate `docker-compose` files and, in turn, an ability to manage those contexts separately:
- Taking down a context to fix issues, modify config, or update images should be possible without taking down *other* contexts. *To correct an issue with Emby, it's not necessary to take down Heimdall*
- Managing the overall Homelab's configuration in a single repo (aka, HERE) should be possible without an individual server needing to run *all* services. This allows for a given server/vm/box to run *certain* contexts - but not necessarily all - while keeping the project manageable. No doubt something like proxmox/kubernetes would have different opinions about this.

Example files:
- ./media-server/docker-compose.yaml
- ./media-server/.env
- ./control-server/dockerfiles/custom-build-for-caddy.dockerfile
- ./control-server/Caddyfile

### Persistent Data and Configuration
`~/home/{$USER}/server`

How your configure the apps and their current states. This is separated from the Docker Compose (ie. "setup") as these become specific to how *you* use the services - not how they're installed/maintained.


### Finalized Media (such as Podcasts, Movies, TV Shows, Audiobooks):
`~/home/{$USER}/media`

This creates a clear distinction between the files *many* services could use or want and the files those services need *just to run*. Separation presumably allows for alternate backup or hosting mechanisms, as well.



## Port Reservations
Ports are controlled through variables to provide a central "fact check"
* TBD


# Optionals
### Caddy and DuckDns.org
- If you do not use DuckDns.org and/or use another provider which needs a Caddy DNS module, alter `dockerfiles/caddy.dockerfile` appropriately
- You can choose to alter docker-compose to point to [snoopeppers/caddy-duckdns](https://hub.docker.com/repository/docker/snoopeppers/caddy-duckdns) instead of having it build the image itself (though, naturally building it yourself will be more stable)
- If you choose to handle Caddy in someother way (eg. don't containerize it) or do not need additional modules, I'd recommend
  - deleting `dockerfiles/caddy.dockerfile`
  - altering docker-compose as required
