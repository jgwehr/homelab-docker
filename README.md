A personal project to provide security, privacy, and data-ownership for my home.

![GitHub last commit](https://img.shields.io/github/last-commit/jgwehr/homelab-docker) ![GitHub Repo Stars](https://img.shields.io/github/stars/jgwehr/homelab-docker)

Includes: 
- Docker and various infrastructure concepts (data backups, parity)
- Self-Hosting for Privacy, such as: Adblocking, Passwords, Family Photos, Finances, Documents
- Self-Hosting for Entertainment, such as: Movies, TV Shows, Music, Board and Video Games
- Self-Hosting for Home, such as: Automation, Grocery Shopping
- Self-Hosting for Friends, such as: Event Scheduling, Idea Curation, Expense Management
- Practical Security: limit exposure surfaces, promote self-healing and proactive measures
- Practical Data Backup: easily export the most important files. Ideally, directly to the cloud and detached storage. Deterministic data is not prioritized.

![Homepage](https://raw.githubusercontent.com/jgwehr/homelab-docker/master/_resources/img/homepage.png)


# Technology

The following apps / technologies are grouped into `./services/`. 

| Service | Note | Includes |
| :- | :- | :- |
| adblock-and-dns |  | <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/pi-hole.png" width="32" alt="Pihole" /> Pihole <img src="https://github.com/walkxcode/dashboard-icons/blob/main/png/pi-hole-unbound.png" width="32" alt="Unbound" /> Unbound |
| change-detect |  | <img src="https://github.com/dgtlmoon/changedetection.io/blob/d5fd22f693d398b9f23a84469b2459b59b02b453/changedetectionio/static/favicons/android-chrome-192x192.png" width="32" alt="ChangeDetection.io"> ChangeDetection.io <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/chrome.png" width="32" alt="Chrome" /> Chrome |
| dashboard |  | <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/homepage.png" width="32" alt="Homepage" /> Homepage |
| downloads |  | <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/qbittorrent.png" width="32" alt="qBitTorrent" /> qBitTorrent <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/gluetun.png" width="32" alt="Gluetun" /> Gluetun <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/radarr.png" width="32" alt="Radarr" /> Radarr <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/sonarr.png" width="32" alt="Sonarr" /> Sonarr <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/lidarr.png" width="32" alt="Lidarr" /> Lidarr <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/prowlarr.png" width="32" alt="Prowlaar" /> Prowlaar <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/metube.png" width="32" alt="Metube" /> Metube + PodGrab |
| events |  | <img src="https://github.com/lukevella/rallly/blob/main/apps/web/public/favicon-32x32.png?raw=true" width="32" alt="Rallly"> Rallly <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/postgres.png" width="32" alt="PostGres" /> PostGres |
| gloomhaven |  | <img src="https://github.com/Lurkars/gloomhavensecretariat/blob/main/src/assets/icons/icon-masked-72x72.png" width="32" alt="Gloomhaven Secretariat" />Gloomhaven Secretariat |
| infra | Required | docker socket proxy |
| image-board |  | <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/pinry.png" width="32" alt="Pinry" /> Pinry |
| media-request |  | <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/jellyseerr.png" width="32" alt="Jellyseerr" /> Jellyseerr |
| media-streaming |  | <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/jellyfin.png" width="32" alt="Jellyfin" /> Jellyfin |
| monitor |  | <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/dozzle.png" width="32" alt="Dozzle" /> Dozzle <img src="https://raw.githubusercontent.com/crazy-max/diun/master/.res/diun.png" width="32" alt="Diun" /> Diun <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/scrutiny.png" width="32" alt="Scrutiny" /> Scrutiny <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/speedtest-tracker.png" width="32" alt="Speedtest Tracker" /> Speedtest Tracker <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/uptime-kuma.png" width="32" alt="Uptime Kuma" /> Uptime Kuma |
| paperless |  | <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/paperless-ng.png" width="32" alt="Paperless ngx" /> Paperless-ngx <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/postgres.png" width="32" alt="PostGres" /> PostGres |
| public | Reverse Proxy and DDNS | <img src="https://caddy-forum-uploads.s3.amazonaws.com/original/2X/3/3859a874d26640df74a3b951d8052a3c3e749eed.png" width="32" alt="Caddy" /> Caddy <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/duckdns.png" width="32" alt="DuckDNS" /> DuckDNS |
| recipes |  | <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/tandoor-recipes.svg" width="32" alt="Tandoor Recipes" /> Tandoor Recipes <img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/postgres.png" width="32" alt="PostGres" /> PostGres |
| security | Run this if you're running `public` | ~~<img src="https://github.com/walkxcode/Dashboard-Icons/blob/main/png/crowdsec.png" width="32" alt="CrowdSec" /> CrowdSec~~ + Endlessh |

### Explanation
Groupings are chosen based on context and dependencies. Most Services "stacks" should work fine without any other services (some exceptions exist) - allowing you to take from this repo what you care about and ignore the rest.
1. All Services **use the same `.env` file** from the root directory (*/opt/docker/homelab-docker/.env*). This simplifies maintenance as some variables are used by multiple Services. This is accomplished via symlink.
1. One-way dependency: *Stack A* can be dependent on Container(s) within *Stack B*, but *Stack B* cannot **also** be dependent on any Containers in *Stack A*. Similarly, *Container A.1* can depend on *Container A.2* but *Container A.2* cannot **also** be dependent on *Container A.1*.
1. Multiple dependencies: Containers can have any number of (efficient) dependencies. *Container A.1* can depend on *Container A.2* and *Container B.1*. Care should be taken to avoid circular dependencies (*A on B on C on A*).
1. Services are easy to manage (start, stop, restart,...) independently from one another. Additionally, some apps (eg. [Dozzle](https://github.com/amir20/dozzle/releases/tag/v6.5.0)) make good use of *separate* docker-compose files to improve their own functionality. 

### Starting services
1. Ensure you've established the symlink to `.env`. See or execute `./scripts/run-each-update.sh`
1. Navigate to the desired service, eg `cd ./services/infra`
1. Execute a standard docker compose up, eg `docker compose up -d`

### Notes
Watchtower is intentionally avoided based off advice from the Selfhosted.show podcast. The idea is to have full control over the versions of containers (rather than automated updates) to improve reliability. Instead, I use Diun and dockcheck.sh currently. 


# Install / Beginning

WIP

1. Become familiar with the Project Structure below. This is your "map" of where to expect different things to be. In turn, this will help you configure your setup correctly
1. **SAMBA**: After copying smb.conf, customize it as needed: interfaces, share names, users, passwords, etc.

# Project Structure
Recommendations via *[multiple docker files](https://nickjanetakis.com/blog/docker-tip-87-run-multiple-docker-compose-files-with-the-f-flag)*, [Where to Put Docker Compose](https://nickjanetakis.com/blog/docker-tip-76-where-to-put-docker-compose-projects-on-a-server), *[TRaSH Guides](https://trash-guides.info/Hardlinks/How-to-setup-for/Docker/)*

## File System

```
├── /opt/
│  └── docker/
│     └── homelab-docker/ (this repo)
│        ├── configtemplates/ (for help with non-docker tools eg. Samba or SnapRaid)
│        ├── scripts/ (for help with managing install, backups, etc)
│        ├── services/
│        |  ├── service1/
|        |  |    ├── docker-compose.yml
|        |  |    ├── ~.env (symlink)
|        |  |    ├── dockerfiles/ (for custom builds)
│        |  |    |   └── *.dockerfile (for adhoc builds)
│        |  |    ├── configtemplates/ (service-specific configuration to be copied to config dir, then customized)
│        |  |    └── staticconfig/ (service-specific configuratio. does not move)
|        |  |        ├── container1/
|        |  |        |  └── container-specific-file.ext
|        |  |        └── container*/
│        |  └── service*/
│        └── .env (the master .env file. Each Service symlinks to this)
├── /srv/
│  ├── docker/ (for container's configurations)
│  ├── cache/
│  └── logs/
└── /mnt/storage/
   ├── db/
   ├── staticfiles/
   │  ├── icons/
   │  ├── paperless/
   │  ├── tandoor_media/
   │  └── wallpaper/
   ├── downloads/
   │  ├── audiobooks/
   │  ├── movies/
   │  ├── music/
   │  ├── paperless/ (SAMBA shared r/w for ingestion)
   │  ├── podcasts/
   │  ├── tv/
   │  └── youtube/
   └── media/
      ├── audiobooks/
      ├── music/
      ├── pictures/
      ├── podcasts/
      ├── movies/
      └── tv/
```

### Directories may be created with the following cmds
Please review this script before running it. It is a **work in progress and may not run as expected**.
`cd scripts`
`chmod +x start.sh`  
`./start.sh`

### Establish Directory and File permissions
TBD - this may vary based on your existing file system, user provisions, and/or usage of mergerfs or similar tools.
Recursively own the /mnt/storage directory
`chown -R $USER:docker /mnt/storage` (the `docker` group is available after Docker installation steps)
`chmod -R a=,a+rX,u+w,g+w /mnt/storage`
* tbd: change permission to underlying disks eg. /mnt/disk1


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
`/mnt/storage/downloads/movies`

### Media Storage (such as Podcasts, Movies, TV Shows, Audiobooks):
`/mnt/storage/media/movies`

This structure helps achieve Least Privilege by separating concerns as efficiently as possible. Clear organization can also help with backup prioritization.

Examples:
* `/mnt/storage/downloads/`: qBittorrent should only have access to this directory.
* `/mnt/storage/`: Radarr has broader access, which allows it to organize files in downloads into media
* `/mnt/storage/media/movies`: Jellyfin has very specific access to playback-ready movies, but not other media such as Podcasts

Nesting the `media` adjacent to `downloads` is suggested via servarr.com as a way to allow **atomic file moves** as opposed to a more intensive/longer **copy+paste** action. Explained [here](https://wiki.servarr.com/docker-guide). Importantly, I configure these services to **hardlink** finished downloads - this preserves seeding ability while having no effect on storage consumption.

### Container Roles and Access to Files
Let's recognize four kinds of Media Server roles containers/apps:

1. A **Curator** whose role is to enable the discovery and selection of Media by an End User. It then delivers a Work Order to the **Acquirer**. It also monitors the Media and ensures it is accurately described and and of desired quality. *Ex. Sonarr, Radarr, Lidarr, Readarr, Ombi*
1. An **Indexer** whose role is to interpret how a Work Order should be completed. It figures out where the Media should come from while negotiating with each supplier. *Ex. Jackett, Prowlaar*
1. An **Acquirer** whose role is to accept and execute a Work Order to retrieve a specific Media. It then delivers that Media to the **Provider**. *Ex. qBitTorrent, Transmission*
1. A **Provider** whose role is to provide Media (movies, podcasts, etc) to end users. It is unconcerned with how the Media came to exist and isn't responsible for its quality or description. *Ex. Emby, Plex, Jellyfin*


## Port Reservations
Ports are controlled through variables (ie. `.env`) to provide a central "fact check".

# Optionals
### Caddy and DuckDns.org
- If you do not use DuckDns.org and/or use another provider which needs a Caddy DNS module, alter `dockerfiles/caddy.dockerfile` appropriately
