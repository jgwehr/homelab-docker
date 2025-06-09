# Establishes the directory structure, users, etc
# Intended for the initial set up of a server; should not be ran after success
#
#



## MergerFS
sh ./system-update_01mergerfs.sh

apt install tree


## Drive Mounting https://perfectmediaserver.com/03-installation/manual-install-proxmox/#mountpoints
### Check Drives
inxi -xD
ls -lA /dev/disk/by-id
####  The /dev/disk/by-id identifier is tied to that specific piece of hardware by drive model and serial number and will therefore never change which is why it is recommended over using /dev/sdc.


### for Each Drive
#>>>    mkdir /mnt/<enumeratedMountPoint1>
#>>>    mount /dev/disk/by-id/<disk-by-id>-part1 /mnt/<enumeratedMountPoint1>

### Verify that the drive mounted and displays the correct size as expected
df -h

## Directory Structure

### Core Disks
mkdir -p /srv/{docker/config,cache,logs}

mkdir -p /mnt/storage # this will be the main mergerfs mountpoint
cd /mnt/storage #or otherwise /data
mkdir -p {db,photos}
mkdir -p documents/paperless
mkdir -p downloads/{audiobooks,movies,music,podcasts,tv,youtube}
mkdir -p media/{audiobooks,movies,music,podcasts,tv}
mkdir -p staticfiles/{icons,tandoor_media,wallpaper}
mkdir -p upload/{paperless,photos}

# take onwership over this folders
sudo chown -R $USER:$USER /mnt/storage
sudo chmod -R a=,a+rX,u+w,g+w /mnt/storage


cd /opt/docker
git clone https://github.com/jgwehr/homelab-docker.git homelab



mkdir /mnt/disk{1,2,3,4} #TODO: Parameterize
mkdir /mnt/parity1 # adjust this command based on your parity setup #TODO: Parameterize
