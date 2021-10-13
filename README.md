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
<img src="https://github.com/NX211/homer-icons/blob/master/png/watchtower.png" width="32" alt="Watchtower" />
<img src="https://github.com/NX211/homer-icons/blob/master/png/portainer.png" width="32" alt="Portainer" />
<img src="https://github.com/louislam/uptime-kuma/blob/master/public/icon.svg" width="32" alt="Uptime Kuma" />

`navigation-server`
<img src="https://github.com/NX211/homer-icons/blob/master/png/heimdall.png" width="32" alt="Heimdall" />

`network-server`
Caddy

`vault-server`
<img src="https://github.com/NX211/homer-icons/blob/master/png/bitwarden.png" width="32" alt="Vaultwarden/Bitwarden" />



# Project Structure
Work in Progress. Recommendations via *[multiple docker files](https://nickjanetakis.com/blog/docker-tip-87-run-multiple-docker-compose-files-with-the-f-flag)* and *[TRaSH Guides](https://trash-guides.info/Hardlinks/How-to-setup-for/Docker/)*

## File System
```
~
├── docker
│  ├── .env
│  ├── control-server.yml
│  ├── navigation-server.yml
│  ├── network-server.yml
│  └── valut-server.yml
│
├── server
│  ├── config
│  └── logs
│
├── Audiobooks
├── Downloads
│  ├── complete (tbd... presuming staging for metadata?)
│     ├── audiobooks
│     ├── movies
│     ├── music
│     └── tv
│  ├── incomplete
│     ├── audiobooks
│     ├── movies
│     ├── music
│     └── tv
│  └── torrents
│     ├── audiobooks
│     ├── movies
│     ├── music
│     └── tv
├── Music
├── Pictures
├── Podcasts
└── Videos
   ├── Movies
   └── TV
```


### Docker Compose (and needed files)
`~/home/{$USER}/docker`

This github repo represents this folder. It's safely committed to public repos and shouldn't contain anything sensitive.

Individual contexts are their own folders. This allows separate `docker-compose` files and, in turn, an ability to manage those contexts separately:
- Taking down a context to fix issues, modify config, or update images should be possible without taking down *other* contexts. *To correct an issue with Emby, it's not necessary to take down Heimdall*
- Managing the overall Homelab's configuration in a single repo (aka, HERE) should be possible without an individual server needing to run *all* services. This allows for a given server/vm/box to run *certain* contexts - but not necessarily all - while keeping the project manageable. No doubt something like proxmox/kubernetes would have different opinions about this.

Example files:
- ./media-server.yaml
- ./.env
- ./dockerfiles/custom-build-for-caddy.dockerfile
- ./Caddyfile

### Persistent Data and Configuration
`~/home/{$USER}/server`

How your configure the apps and their current states. This is separated from the Docker Compose (ie. "setup") as these become specific to how *you* use the services - not how they're installed/maintained.


### Finalized Media (such as Podcasts, Movies, TV Shows, Audiobooks):
`~/home/{$USER}/Videos/Movies`
`~/home/{$USER}/Podcasts`

This creates a clear distinction between the files *many* services could use or want and the files those services *just need to access*. Separation presumably allows for alternate backup or hosting mechanisms, as well. It's an attempt to achieve Least Privilege.



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
