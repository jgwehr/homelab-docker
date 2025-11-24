varDate=$(date +%Y-%m-%d)
varBackupDir=/home/user/backup/$varDate
varConfigDir=/srv/docker
varOptDir=/opt/docker/homelab
varStaticDir=/mnt/ssd/staticfiles

# Formatting
C_COMPOSE="\e[48;5;26m"
C_ZIP="\e[48;5;220m"
C_EOL="\e[0m"


mkdir -p $varBackupDir/$varDate
cd $varBackupDir/$varDate

# Attempt to document image tags, ports, and other container configuration
echo "Backing up Docker outputs (tags, ports, names)..."
docker ps > docker-ps.txt
docker image ls > docker-image-ls.txt

# Environment Files
echo Backing up .env...
cp -rpi $varOptDir/.env $varBackupDir/$varDate

# fstab / Diskmounts
echo Backing up fstab...
cp -rpi /etc/fstab $varBackupDir/$varDate

# SnapRaid
echo Backing up SnapRaid Conf...
cp -rpi /etc/snapraid.conf $varBackupDir/$varDate

echo Backing up SnapRaid Runner...
cp -rpi /opt/snapraid-runner/snapraid-runner.conf $varBackupDir/$varDate

# Samba
echo Backing up Samba...
cp -rpi /etc/samba/smb.conf $varBackupDir/$varDate

# Database backups (must be done while containers are still running...)
echo Backing up Databases...
sudo docker exec -t tandoor_db pg_dumpall -U tandoor_user > tandoor_pgdump.sql
sudo docker exec -t paperless_db pg_dumpall -U paperless_app > paperless_pgdump.sql

# Pihole Teleport
mkdir -p $varBackupDir/$varDate/pihole
cd $varBackupDir/$varDate
# at this time, --teleport doesn't allow setting a file name and returns more than the filename it generates.
# Nor does docker cp allow wildcards. So this is all a workaround to get to the right .zip
varPiholeTmpDir=/etc/pihole/teleport_backups
sudo docker exec -t pihole mkdir -p $varPiholeTmpDir
sudo docker exec -t --workdir $varPiholeTmpDir pihole pihole-FTL --teleporter
docker cp pihole:$varPiholeTmpDir ./pihole
sudo docker exec -t pihole rm -rf $varPiholeTmpDir


# Stop Docker for safety
echo "${C_COMPOSE}Shutting Containers Down...${C_EOL}"

cd $varOptDir/services/adblock-and-dns && docker compose down # pihole and unbound
cd $varOptDir/services/change-detect && docker compose down # change-detection.io and chrome
cd $varOptDir/services/dashboard && docker compose down # homepage
cd $varOptDir/services/downloads && docker compose down # *arr
cd $varOptDir/services/events && docker compose down # Rallly
cd $varOptDir/services/gloomhaven && docker compose down # GHS
cd $varOptDir/services/media-request && docker compose down # Jellyseerr
cd $varOptDir/services/media-streaming && docker compose down # Jellyfin
cd $varOptDir/services/monitor && docker compose down # uptime kuma, dozzle, diun, speedtracker
cd $varOptDir/services/paperless && docker compose down # paperless
cd $varOptDir/services/public && docker compose down # Caddy and Duckdns
cd $varOptDir/services/recipes && docker compose down # Tandoor
cd $varOptDir/services/security && docker compose down # Endlessh, Crowdsec


# Docker config backups
echo Backing up Docker Configs...
printf "[                  ] 0/16\r"

mkdir -p $varBackupDir/$varDate/changedetection
varTempChangeDetectionBackup=$(ls -Art $varConfigDir/changedetection/*.zip | tail -n 1)
cp -rpi $varTempChangeDetectionBackup $varBackupDir/$varDate/changedetection
printf "[#                 ] 1/16\r"

mkdir -p $varBackupDir/$varDate/ghs && cp -rpi $varConfigDir/ghs/ghs.sqlite $varBackupDir/$varDate/ghs
printf "[##                ] 2/16\r"

mkdir -p $varBackupDir/$varDate/homepage && cp -rpi $varConfigDir/homepage/*.yaml $varBackupDir/$varDate/homepage
printf "[###               ] 3/16\r"

mkdir -p $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/config $varBackupDir/$varDate/jellyfin
## Recent Jellyfin updates have *exploded* the data/ directory, my Subtitles folder is 1.2G. These aren't important to me, so they're excluded
cp -rpi $varConfigDir/jellyfin/data/collections $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/data/device.txt $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/data/fileorganization.db $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/data/jellyfin.db $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/data/library.db $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/data/playlists $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/root $varBackupDir/$varDate/jellyfin
printf "[####              ] 4/18\r"

mkdir -p $varBackupDir/$varDate/jellyseerr
cp -rpi $varConfigDir/jellyseerr/db $varBackupDir/$varDate/jellyseerr
cp -rpi $varConfigDir/jellyseerr/settings.json $varBackupDir/$varDate/jellyseerr
printf "[#####             ] 5/16\r"


# the *arr containers smartly have scheduled backups. So we pull only the most recent to save disk space
mkdir -p $varBackupDir/$varDate/prowlarr
varTempProwlarrBackup=$(ls -Art $varConfigDir/prowlarr/Backups/scheduled | tail -n 1)
cp -rpi $varConfigDir/prowlarr/Backups/scheduled/$varTempProwlarrBackup $varBackupDir/$varDate/prowlarr
printf "[######            ] 6/16\r"

mkdir -p $varBackupDir/$varDate/lidarr
varTempRadarrBackup=$(ls -Art $varConfigDir/lidarr/Backups/scheduled | tail -n 1)
cp -rpi $varConfigDir/lidarr/Backups/scheduled/$varTempRadarrBackup $varBackupDir/$varDate/lidarr
printf "[#######           ] 7/16\r"

mkdir -p $varBackupDir/$varDate/radarr3
varTempRadarrBackup=$(ls -Art $varConfigDir/radarr3/Backups/scheduled | tail -n 1)
cp -rpi $varConfigDir/radarr3/Backups/scheduled/$varTempRadarrBackup $varBackupDir/$varDate/radarr3
printf "[########          ] 8/16\r"

mkdir -p $varBackupDir/$varDate/sonarr
varTempSonarrBackup=$(ls -Art $varConfigDir/sonarr/Backups/scheduled | tail -n 1)
cp -rpi $varConfigDir/sonarr/Backups/scheduled/$varTempSonarrBackup $varBackupDir/$varDate/sonarr
printf "[#########         ] 9/16\r"

mkdir -p $varBackupDir/$varDate/qbittorrent
cp -rpi $varConfigDir/qbt/qBittorrent/qBittorrent.conf $varBackupDir/$varDate/qbittorrent
printf "[##########        ] 10/16\r"

mkdir -p $varBackupDir/$varDate/gluetun
cp -rpi $varConfigDir/gluetun/servers.json $varBackupDir/$varDate/gluetun
printf "[###########       ] 11/16\r"

mkdir -p $varBackupDir/$varDate/unbound
cp -rpi $varConfigDir/pihole-unbound/unbound $varBackupDir/$varDate/unbound
printf "[############      ] 12/16\r"

mkdir -p $varBackupDir/$varDate/podgrab
cp -rpi $varConfigDir/podgrab/podgrab.db $varBackupDir/$varDate/podgrab
varTempPodgrabBackup=$(ls -Art $varConfigDir/podgrab/backups | tail -n 1)
cp -rpi $varConfigDir/podgrab/backups/$varTempPodgrabBackup $varBackupDir/$varDate/podgrab/backups
printf "[##############    ] 13/16\r"

mkdir -p $varBackupDir/$varDate/ripping && cp -rpi $varConfigDir/ripping $varBackupDir/$varDate
printf "[###############   ] 14/16\r"

mkdir -p $varBackupDir/$varDate/scrutiny && cp -rpi $varConfigDir/scrutiny $varBackupDir/$varDate
printf "[################  ] 15/16\r"

mkdir -p $varBackupDir/$varDate/uptime-kuma
cp -rpi $varConfigDir/uptime-kuma/kuma.db $varBackupDir/$varDate/uptime-kuma
printf "[##################] 16/16\r"

printf "\n"


# Zip file
echo "${C_ZIP}Creating Primary Zip...${C_EOL}"
cd $varBackupDir
du -h --max-depth=1 $varDate | sort -hr
zip -r -9 $varDate $varDate > /dev/null 2>&1


####################
# Large File Storage Backups
####################

echo Backing Up Paperless: Classification Model...
mkdir -p $varBackupDir/$varDate-paperless/paperless
cp -rpi $varConfigDir/paperless/classification_model.pickle $varBackupDir/$varDate-paperless/paperless
cp -rpi $varConfigDir/paperless/index $varBackupDir/$varDate-paperless/paperless/index

echo "${C_COMPOSE}Starting Paperless...${C_EOL}"
cd $varOptDir/services/paperless && docker compose up -d # paperless

echo Backing Up Paperless: Documents...
sudo docker exec paperless document_exporter /usr/src/paperless/export --zip #location is within paperless container
varTempPaperlessBackup=$(ls -Art /home/user/backup/paperless | tail -n 1) # grab the most recent zip from the volume-mapped directory. Must align with your .env BACKUPDIR
cp -rpi /home/user/backup/paperless/$varTempPaperlessBackup $varBackupDir/$varDate-paperless/documents.zip

echo "${C_ZIP}Creating Paperless Zip...${C_EOL}"
cd $varBackupDir
zip -r -9 $varDate-paperless $varDate-paperless > /dev/null 2>&1



####################
# Cleanup
####################
echo Cleaning up...
rm -rf $varBackupDir/$varDate
rm -rf $varBackupDir/$varDate-paperless
#rm /home/user/backup/paperless/*.* #cleanup


# start docker again. Note, specific profiles may need restarted manually
echo "${C_COMPOSE}Starting Docker Containers...${C_EOL}"

cd $varOptDir/services/adblock-and-dns && docker compose up -d # pihole and unbound
cd $varOptDir/services/change-detect && docker compose up -d # change-detection.io and chrome
cd $varOptDir/services/dashboard && docker compose up -d # homepage
cd $varOptDir/services/downloads && docker compose up -d # *arr
cd $varOptDir/services/events && docker compose up -d # Rallly
cd $varOptDir/services/gloomhaven && docker compose up -d # GHS
cd $varOptDir/services/media-request && docker compose up -d # Jellyseerr
cd $varOptDir/services/media-streaming && docker compose up -d # Jellyfin
cd $varOptDir/services/monitor && docker compose up -d # uptime kuma, dozzle, diun, speedtracker
cd $varOptDir/services/public && docker compose up -d # Caddy and Duckdns
cd $varOptDir/services/recipes && docker compose up -d # Tandoor
cd $varOptDir/services/security && docker compose up -d # Endlessh, Crowdsec