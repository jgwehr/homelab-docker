varDate=$(date +%Y%m%d)
varBackupDir=/home/user/backup
varConfigDir=/srv/docker
varOptDir=/opt/docker/homelab

mkdir -p $varBackupDir/$varDate
cd $varBackupDir/$varDate

# Database backups
echo Backing up Databases...
sudo docker exec -t tandoor_db pg_dumpall -U tandoor_user > tandoor_pgdump.sql



# Docker config backups
echo Backing up Docker Configs...

mkdir -p $varBackupDir/$varDate/ghs && cp -rpi $varConfigDir/ghs $varBackupDir/$varDate

mkdir -p $varBackupDir/$varDate/homepage && cp -rpi $varConfigDir/homepage/*.yaml $varBackupDir/$varDate/homepage

mkdir -p $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/config $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/data $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/root $varBackupDir/$varDate/jellyfin

mkdir -p $varBackupDir/$varDate/jellyseerr
cp -rpi $varConfigDir/jellyseerr/db $varBackupDir/$varDate/jellyseerr
cp -rpi $varConfigDir/jellyseerr/settings.json $varBackupDir/$varDate/jellyseerr


# the *arr containers smartly have scheduled backups. So we pull only the most recent to save disk space
mkdir -p $varBackupDir/$varDate/prowlarr
varTempProwlarrBackup=$(ls -Art $varConfigDir/prowlarr/Backups/scheduled | tail -n 1)
cp -rpi $varConfigDir/prowlarr/Backups/scheduled/$varTempProwlarrBackup $varBackupDir/$varDate/prowlarr

mkdir -p $varBackupDir/$varDate/radarr3
varTempRadarrBackup=$(ls -Art $varConfigDir/radarr3/Backups/scheduled | tail -n 1)
cp -rpi $varConfigDir/radarr3/Backups/scheduled/$varTempRadarrBackup $varBackupDir/$varDate/radarr3

mkdir -p $varBackupDir/$varDate/sonarr
varTempSonarrBackup=$(ls -Art $varConfigDir/sonarr/Backups/scheduled | tail -n 1)
cp -rpi $varConfigDir/sonarr/Backups/scheduled/$varTempSonarrBackup $varBackupDir/$varDate/sonarr

mkdir -p $varBackupDir/$varDate/qbittorrent
cp -rpi $varConfigDir/qbt/qBittorrent/qBittorrent.conf $varBackupDir/$varDate/qbittorrent

mkdir -p $varBackupDir/$varDate/pihole && cp -rpi $varConfigDir/pihole $varBackupDir/$varDate

mkdir -p $varBackupDir/$varDate/pinry
cp -rpi $varConfigDir/pinry/*.* $varBackupDir/$varDate/pinry

mkdir -p $varBackupDir/$varDate/podgrab
cp -rpi $varConfigDir/podgrab/podgrab.db $varBackupDir/$varDate/podgrab
varTempPodgrabBackup=$(ls -Art $varConfigDir/podgrab/backups | tail -n 1)
cp -rpi $varConfigDir/podgrab/backups $varBackupDir/$varDate/podgrab

mkdir -p $varBackupDir/$varDate/ripping && cp -rpi $varConfigDir/ripping $varBackupDir/$varDate/ripping

mkdir -p $varBackupDir/$varDate/scrutiny && cp -rpi $varConfigDir/scrutiny $varBackupDir/$varDate/scrutiny

mkdir -p $varBackupDir/$varDate/unbound && cp -rpi $varConfigDir/unbound $varBackupDir/$varDate/unbound

mkdir -p $varBackupDir/$varDate/uptime-kuma
cp -rpi $varConfigDir/uptime-kuma/kuma.db $varBackupDir/$varDate/uptime-kuma

mkdir -p $varBackupDir/$varDate/wireguard
cp -rpi $varConfigDir/wireguard/wg0.conf $varBackupDir/$varDate/wireguard



# Environment Files
echo Backing up .env...
cp -rpi $varOptDir/.env $varBackupDir/$varDate

# SnapRaid
echo Backing up SnapRaid Conf...
cp -rpi /etc/snapraid.conf $varBackupDir/$varDate

echo Backing up SnapRaid Runner...
cp -rpi /opt/snapraid-runner/snapraid-runner.conf $varBackupDir/$varDate


# Zip file
echo Creating Primary Zip...
cd $varBackupDir
du -h --max-depth=1 $varDate | sort -hr
zip -r -9 $varDate $varDate > /dev/null 2>&1


# Large File Storage Backups
echo Backing Up Pinry Media
mkdir -p $varBackupDir/$varDate-pinry
cp -rpi $varConfigDir/pinry/static/media $varBackupDir/$varDate-pinry
echo Creating Pinry Media Zip...
cd $varBackupDir/$varDate-pinry
zip -r -9 $varDate-pinry $varDate-pinry > /dev/null 2>&1