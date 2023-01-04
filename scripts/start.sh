varBackupDir=/home/user/backup
varConfigDir=/srv/docker
varOptDir=/opt/docker/homelab





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

# SnapRaid
cp $varOptDir/configtemplates/snapraid/snapraid.conf /etc/snapraid.conf
mkdir -p /var/snapraid


# Pihole
cp -rpi $varOptDir/configtemplates/pihole/resolv.conf $varConfigDir/pihole/resolv.conf

# Unbound
cp -rpi $varOptDir/configtemplates/unbound/* $varConfigDir/unbound



# Docker Setup
sudo groupadd docker
sudo usermod -aG docker $USER

docker network create web
docker network create caddy-net
docker network create -d bridge --subnet 172.20.0.0/16 dns-net
docker volume create crowdsec-config
docker volume create crowdsec-db


# Print user info
id


# Jellyfin
useradd jellyfin
usermod -aG render jellyfin
id jellyfin