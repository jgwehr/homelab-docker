# File System


cd /srv
mkdir -p {docker/config,cache,logs}
cd /opt/docker
git clone https://github.com/jgwehr/homelab-docker.git


cd /data
mkdir -p db
mkdir -p downloads/{audiobooks,music,podcasts,movies,tv}}
mkdir -p media/{audiobooks,music,pictures,podcasts,movies,tv}
sudo chown -R $USER:$USER /data
sudo chmod -R a=,a+rX,u+w,g+w /data


# Docker Setup
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