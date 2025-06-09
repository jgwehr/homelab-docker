####################
# Configure the below variables
####################

varConfigDir=/srv/docker
varOptDir=/opt/docker/homelab
varMediaStorage=/mnt/storage



####################
# Anything below this doesn't need changing, unless you want to customize your homelab
####################

### Downloads latest version of MergerFSfrom github for your os_release. https://perfectmediaserver.com/02-tech-stack/mergerfs/
curl -s https://api.github.com/repos/trapexit/mergerfs/releases/latest | grep "browser_download_url.*$(grep VERSION_CODENAME /etc/os-release | cut -d= -f2)_$(dpkg --print-architecture).deb\"" | cut -d '"' -f 4 | wget -qi - && sudo dpkg -i mergerfs_*$(grep VERSION_CODENAME /etc/os-release | cut -d= -f2)_$(dpkg --print-architecture).deb && rm mergerfs_*.deb

### Verify installation
apt list mergerfs

### Additional tools
apt install duf tree

# File System: Configuration and Core Options
cd /srv
mkdir -p {cache,logs}
mkdir -p $varConfigDir #/srv/docker
cd $varOptDir
git clone https://github.com/jgwehr/homelab-docker.git homelab


# File System: Media storage (aka your files)
mkdir -p $varMediaStorage
cd $varMediaStorage # This uses MergerFS. For a simpler version, use /data

mkdir -p {db,photos}
mkdir -p documents/paperless
mkdir -p downloads/{audiobooks,movies,music,podcasts,tv,youtube}
mkdir -p media/{audiobooks,movies,music,podcasts,tv}
mkdir -p staticfiles/{icons,tandoor_media,wallpaper}
mkdir -p upload/{paperless,photos}

# take onwership over this folders
sudo chown -R $USER:$USER /mnt/storage
sudo chmod -R a=,a+rX,u+w,g+w /mnt/storage



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

# Pihole
cp -rpi $varOptDir/services/adblock-and-dns/configtemplates/pihole/resolv.conf $varConfigDir/pihole/resolv.conf

# Scrutiny
cp -rpi $varOptDir/services/monitor/configtemplates/scrutiny/* $varConfigDir/scrutiny

# Unbound
cp -rpi $varOptDir/services/adblock-and-dns/configtemplates/unbound/* $varConfigDir/unbound



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
