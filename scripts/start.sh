####################
# Configure the below variables
####################

varConfigDir=/srv/docker
varOptDir=/opt/docker/homelab
varMediaStorage=/mnt/storage



####################
# Anything below this doesn't need changing, unless you want to customize your homelab
####################

# File System: Configuration and Core Options
cd /srv
mkdir -p {docker,cache,logs}
cd $varOptDir
git clone https://github.com/jgwehr/homelab-docker.git


# File System: Media storage (aka your files)
cd $varMediaStorage # This uses MergerFS. For a simpler version, use /data
mkdir -p db
mkdir -p downloads/{audiobooks,music,podcasts,movies,tv}
mkdir -p media/{audiobooks,music,pictures,podcasts,movies,tv}
mkdir -p staticfiles
sudo chown -R $USER:$USER $varMediaStorage/{db,downloads,media,staticfiles}
sudo chmod -R a=,a+rX,u+w,g+w $varMediaStorage/{db,downloads,media,staticfiles}



####################
# Infrastructure
####################

# SnapRaid
cp $varOptDir/configtemplates/snapraid/snapraid.conf /etc/snapraid.conf
mkdir -p /var/snapraid

# Samba
sudo apt install samba
cp -rpi $varOptDir/configtemplates/samba/smb.conf /etc/samba/smb.conf
sudo ufw allow samba


####################
# Service / Container specific
####################

# ghs
cp -rpi $varOptDir/services/gloomhaven/configtemplates/ghs/application.properties $varConfigDir/ghs/application.properties

# homepage
cp -rpi $varOptDir/services/dashboard/configtemplates/homepage $varConfigDir/homepage

# Scrutiny
cp -rpi $varOptDir/services/monitor/configtemplates/scrutiny/* $varConfigDir/scrutiny

# Unbound
sudo mkdir -p $varConfigDir/pihole-unbound/pihole/etc-pihole
sudo mkdir -p $varConfigDir/pihole-unbound/pihole/etc-dnsmasq.d
sudo mkdir -p $varConfigDir/pihole-unbound/unbound/etc-unbound
sudo mkdir -p $varConfigDir/pihole-unbound/unbound/unbound.conf.d

touch $varConfigDir/pihole-unbound/unbound/etc-unbound/unbound.log

chown -R $USER:docker $varConfigDir/pihole-unbound
chmod -R 755 $varConfigDir/pihole-unbound

cp -rpi $varOptDir/services/adblock-and-dns/configtemplates/unbound/* $varConfigDir/pihole-unbound/unbound



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
