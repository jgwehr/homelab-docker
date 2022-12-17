# File System
cd /srv
mkdir -p {docker/config,cache,logs}
cd /opt/docker
git clone https://github.com/jgwehr/homelab-docker.git homelab


cd /mnt/storage #or otherwise /data
mkdir -p db
mkdir -p downloads/{audiobooks,music,podcasts,movies,tv}
mkdir -p media/{audiobooks,music,pictures,podcasts,movies,tv}
mkdir -p staticfiles
sudo chown -R $USER:$USER /mnt/storage/{db,downloads,media,staticfiles}
sudo chmod -R a=,a+rX,u+w,g+w /mnt/storage/{db,downloads,media,staticfiles}


# Docker Setup
sudo groupadd docker
sudo usermod -aG docker $USER

docker network create web
docker network create caddy-net
docker volume create crowdsec-config
docker volume create crowdsec-db


# Print user info
id


# Jellyfin
useradd jellyfin
usermod -aG render jellyfin
id jellyfin