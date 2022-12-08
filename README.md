A personal project as I start to learn how to run a Homelab. 

![GitHub last commit](https://img.shields.io/github/last-commit/jgwehr/homelab-docker) ![GitHub Repo Stars](https://img.shields.io/github/stars/jgwehr/homelab-docker)

Includes: 
- Learning Docker, Docker Compose
- Self-Hosting for Privacy, such as: BitWarden, PiHole, Unbound, Wireguard
- Self-Hosting for Entertainment, such as: Plex, Gloomhaven Campaign & Tracker, RetroPi
- Self-Hosting for Small Business, such as: Akaunting, Tabby
- Self-Hosting for Friends, such as: SheetAble, Minecraft

# Technology
- Homepage
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/tandoorrecipes.png" width="32" alt="Tandoor Recipes" /> Tandoor Recipes
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/jellyfin.png" width="32" alt="Jellyfin" /> Jellyfin
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/jellyseerr.png" width="32" alt="Jellyseerr" /> Jellyseerr
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/prowlarr.png" width="32" alt="Prowlaar" /> Prowlaar
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/sonarr.png" width="32" alt="Sonarr" /> Sonarr
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/radarr.png" width="32" alt="Radarr" /> Radarr
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/qbittorrent.png" width="32" alt="qBitTorrent" /> qBitTorrent
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/wireguard.png" width="32" alt="Wireguard" /> Wireguard
- <img src="https://github.com/Lurkars/gloomhavensecretariat/blob/main/src/assets/icons/icon-masked-72x72.png" width="32" alt="Gloomhaven Secretariat" />Gloomhaven Secretariat
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/uptime-kuma.png" width="32" alt="Uptime Kuma" /> Uptime Kuma
- <img src="https://caddy-forum-uploads.s3.amazonaws.com/original/2X/3/3859a874d26640df74a3b951d8052a3c3e749eed.png" width="32" alt="Caddy" /> Caddy
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/crowdsec.png" width="32" alt="CrowdSec" /> CrowdSec
- Endlessh
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/duckdns.png" width="32" alt="DuckDNS" /> DuckDNS
- <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/dozzle.png" width="32" alt="Dozzle" /> Dozzle
- <img src="https://raw.githubusercontent.com/crazy-max/diun/master/.res/diun.png" width="32" alt="Diun" /> Diun

### Notes
Watchtower is intentionally avoided based off advice from the Selfhosted.show podcast. The idea is to have full control over the versions of containers (rather than automated updates) to improve reliability.

# Setup and Operation

## Starting services

### Explanation
Services are grouped into similar purposes via "Profiles". There are two primary goals:

1.  Enable one docker-compose file to be useful in a variety of situations. A server with less resources can easily run a limited version without "fluff". Stacks can easily be started/stopped/restarted, which can help make testing or issue resolution faster
1.  Mitigate docker timeouts. As more services are added, it's more likely a monolithic docker-compose would fail to run successfully.
1.  Less primary: I tried to get multiple docker-compose files to work with a shared collection of environment files (eg. `ports.env`). Unfortunately, Docker really doesn't like that. Symlinks or scripts are  an option, but prohibitively complex. Profiles appear to achieve the best combination of (1) "modularity" and (2) easy of env maintenance

### Start each service
`docker-compose --profile **stack** up -d`
Alternatively, customize `COMPOSE_PROFILES=` in the .env file for a more "static" approach

| Profile               | Services   | Note |
| :--                   | :--:       | :-- |
| `external` | docker-socket-proxy, crowdsec, endlessh, caddy, duckdns | Makes connecting to a publicly facing set of services possible, securely |
| `admin` | docker-socket-proxy, uptime-kuma, homepage | Local system management and status. Non-local access to Uptime Kuma requires  `external` |
| `monitor` | docker-socket-proxy, dozzle, diun, scrutiny | Monitoring system health |
| `downloads` | wireguard,  qbittorrent | Allow for secure file transfers, without additional overhead from library management |
| `media-request` | jellyseerr, sonarr, radarr, prowlarr, wireguard,  qbittorrent | Full stack for end user media requests and file transfer. Non-local access to Jellyseerr requires  `external` |
| `recipes` | tandoor_recipes, postres | Home recipes. Non-local access to tandoor requires  `external` |
| `gloomhaven` | gloomhaven-secretary, ghs-server | Board games! Non-local access to client and server requires  `external` |
| `ripping` | automatic-ripping machine | local-only, not required all the time |


# Project Structure
Work in Progress. Recommendations via *[multiple docker files](https://nickjanetakis.com/blog/docker-tip-87-run-multiple-docker-compose-files-with-the-f-flag)*, [Where to Put Docker Compose](https://nickjanetakis.com/blog/docker-tip-76-where-to-put-docker-compose-projects-on-a-server) *[TRaSH Guides](https://trash-guides.info/Hardlinks/How-to-setup-for/Docker/)*

## File System

```
├── /opt
│  └── docker
│     └── homelab-docker (this repo)
|        ├── dockerfiles (for custom builds)
│        |  └── builder-*.sh (for building files to upload)
│        |  └── *.dockerfile (for adhoc builds)
|        ├── staticconfig (service-specific configuration)
│        |  └── * (for each service)
│        |     └── *
│        ├── .env
│        └── docker-compose.yml
├── /srv
│  └── docker
│  |  └── config
│  ├── cache
│  └── logs
│
└── /data
   ├── db
   ├── downloads
   │  ├── audiobooks
   │  ├── movies
   │  ├── music
   │  ├── podcasts
   │  └── tv
   └── media
      ├── audiobooks
      ├── music
      ├── pictures
      ├── podcasts
      ├── movies
      └── tv
```

### These may be created with the following cmds
`chmod +x start.sh`  
`./start.sh`

### Recursively own the /data directory
sudo chown -R $USER:$USER /data
sudo chmod -R a=,a+rX,u+w,g+w /data


### Docker Compose (and needed files)
`/opt`
*explanation: reserved for the installation of add-on application software packages*

This github repo represents this folder. It's safely committed to public repos and shouldn't contain anything sensitive.

Example files:
- ./docker-compose.yml
- ./.env
- ./dockerfiles/custom-build-for-caddy.dockerfile
- ./staticonfig/caddy/Caddyfile

### Persistent Data and Configuration
`/srv`

How you configure the apps and their current states. This is separated from the Docker Compose (ie. "setup") as these become specific to how *you* use the services - not how they're installed/maintained.

### Media Staging (such as magnets)
`/data/downloads`

### Media Storage (such as Podcasts, Movies, TV Shows, Audiobooks):
`/data/media/movies`
`/data/media/podcasts`

This creates a clear distinction between the files *many* services could use or want and the files those services *just need to access*. Separation presumably allows for alternate backup or hosting mechanisms, as well. It's an attempt to achieve Least Privilege.

Nesting the `media` adjacent to `downloads` is suggested via servarr.com as a way to allow **atomic file moves** as opposed to a more intensive/longer **copy+paste** action. Explained [here](https://wiki.servarr.com/docker-guide).

### Container Roles and Access to Files
Let's recognize four kinds of Media Server roles containers/apps:

1. A **Curator** whose role is to enable the discovery and selection of Media by an End User. It then delivers a Work Order to the **Acquirer**. It also monitors the Media and ensures it is accurately described and and of desired quality.*Ex. Sonarr, Radarr, Lidarr, Readarr, Ombi*
1. An **Indexer** whose role is to interpret how a Work Order should be completed. It figures out where the Media should come from while negotiating with each supplier. *Ex. Jackett, Prowlaar*
1. An **Acquirer** whose role is to accept and execute a Work Order to retrieve a specific Media. It then delivers that Media to the **Provider**. *Ex. qBitTorrent, Transmission*
1. A **Provider** whose role is to provide Media (movies, podcasts, etc) to end users. It is unconcerned with how the Media came to exist and isn't responsible for its quality or description. *Ex. Emby, Plex, Jellyfin*


## Port Reservations
Ports are controlled through variables to provide a central "fact check".

WIP

| Service               | Purpose   | Environment Variable      |
| :--                   | :--       | :--                       |
| Auto Ripping Machine  | Web       | PORT_RIPPING                |
| Dozzle                | Web       | PORT_DOZZLE      |
| Gloomhaven, Client    | Web       | PORT_GHS_CLIENT      |
| Gloomhaven, Server    | Server    | PORT_GHS_SERVER      |
| Tandoor               | Web        | PORT_TANDOOR                   |

# Optionals
### Caddy and DuckDns.org
- If you do not use DuckDns.org and/or use another provider which needs a Caddy DNS module, alter `dockerfiles/caddy.dockerfile` appropriately
