A personal project as I start to learn how to run a Homelab. 

![GitHub last commit](https://img.shields.io/github/last-commit/jgwehr/homelab-docker)

Includes: 
- Learning Docker, Docker Compose
- Self-Hosting for Privacy, such as: BitWarden, PiHole, Unbound, Wireguard
- Self-Hosting for Entertainment, such as: Plex, Gloomhaven Campaign & Tracker, RetroPi
- Self-Hosting for Small Business, such as: Akaunting, Tabby
- Self-Hosting for Friends, such as: SheetAble, Minecraft

# Technology
- <img src="https://caddy-forum-uploads.s3.amazonaws.com/original/2X/3/3859a874d26640df74a3b951d8052a3c3e749eed.png" width="32" alt="Caddy" /> Caddy
- <img src="https://github.com/NX211/homer-icons/blob/master/png/portainer.png" width="32" alt="Portainer" /> Portainer
- <img src="https://github.com/louislam/uptime-kuma/blob/master/public/icon.svg" width="32" alt="Uptime Kuma" /> Uptime Kuma
- <img src="https://github.com/NX211/homer-icons/blob/master/png/heimdall.png" width="32" alt="Heimdall" /> Heimdall
- <img src="https://github.com/NX211/homer-icons/blob/master/png/bitwarden.png" width="32" alt="Vaultwarden/Bitwarden" /> Bitwarden

### Notes
Watchtower is intentionally avoided based off advice from the Selfhosted.show podcast. The idea is to have full control over the versions of containers (rather than automated updates) to improve reliability.

# Project Structure
Work in Progress. Recommendations via *[multiple docker files](https://nickjanetakis.com/blog/docker-tip-87-run-multiple-docker-compose-files-with-the-f-flag)* and *[TRaSH Guides](https://trash-guides.info/Hardlinks/How-to-setup-for/Docker/)*

## File System
```
~
├── docker
│  ├── .env
│  └── docker-compose.yml
│
├── server
│  ├── cache
│  ├── config
│  └── logs
│
└── data
   ├── downloads
   │  ├── complete (tbd... presuming staging for metadata?)
   │  │  ├── audiobooks
   │  │  ├── movies
   │  │  ├── music
   │  │  ├── podcasts
   │  │  └── tv
   │  ├── incomplete
   │  │  ├── audiobooks
   │  │  ├── movies
   │  │  ├── music
   │  │  └── tv
   │  └── torrents
   │     ├── audiobooks
   │     ├── movies
   │     ├── music
   │     └── tv
   └── media
      ├── audiobooks
      ├── music
      ├── pictures
      ├── podcasts
      ├── movies
      └── tv
```

### These may be created with the following cmds
`mkdir -p ~/{docker,server/{cache,config,logs},data/{media/{audiobooks,music,pictures,podcasts,movies,tv},downloads/{complete/{audiobooks,music,podcasts,movies,tv},incomplete/{audiobooks,music,movies,tv},torrents/{audiobooks,music,movies,tv}}}}`

### Docker Compose (and needed files)
`~/home/{$USER}/docker`

This github repo represents this folder. It's safely committed to public repos and shouldn't contain anything sensitive.

Example files:
- ./docker-compose.yml
- ./.env
- ./dockerfiles/custom-build-for-caddy.dockerfile
- ./Caddyfile


Ideally, individual contexts are separated - distinct "stacks" which can be managed (up/down/restart/etc). Unfortuantely, I'm not smart enough for that yet.
- Taking down a context to fix issues, modify config, or update images should be possible without taking down *other* contexts. *To correct an issue with Emby, it's not necessary to take down Heimdall*
- Managing the overall Homelab's configuration in a single repo (aka, HERE) should be possible without an individual server needing to run *all* services. This allows for a given server/vm/box to run *certain* contexts - but not necessarily all - while keeping the project manageable. No doubt something like proxmox/kubernetes would have different opinions about this.

### Persistent Data and Configuration
`~/home/{$USER}/server`

How your configure the apps and their current states. This is separated from the Docker Compose (ie. "setup") as these become specific to how *you* use the services - not how they're installed/maintained.


### Media Storage (such as Podcasts, Movies, TV Shows, Audiobooks):
`~/home/{$USER}/data/media/movies`
`~/home/{$USER}/data/media/podcasts`

This creates a clear distinction between the files *many* services could use or want and the files those services *just need to access*. Separation presumably allows for alternate backup or hosting mechanisms, as well. It's an attempt to achieve Least Privilege.

Nesting the `media` adjacent to `torrents` is suggested via servarr.com as a way to allow **atomic file moves** as opposed to a more intensive/longer **copy+paste** action. Explained [here](https://wiki.servarr.com/docker-guide).

### Container Roles and Access to Files
Let's recognize four kinds of Media Server roles containers/apps:

1. A **Curator** whose role is to enable the discovery and selection of Media by an End User. It then delivers a Work Order to the **Acquirer**. It also monitors the Media and ensures it is accurately described and and of desired quality.*Ex. Sonarr, Radarr, Lidarr, Readarr, Ombi*
1. An **Indexer** whose role is to interpret how a Work Order should be completed. It figures out where the Media should come from while negotiating with each supplier. *Ex. Jackett, Prowlaar*
1. An **Acquirer** whose role is to accept and execute a Work Order to retrieve a specific Media. It then delivers that Media to the **Provider**. *Ex. Transmission*
1. A **Provider** whose role is to provide Media (movies, podcasts, etc) to end users. It is unconcerned with how the Media came to exist and isn't responsible for its quality or description. *Ex. Emby, Plex, Jellyfin*


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
