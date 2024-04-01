varDate=$(date +%Y-%m-%d)
varBackupDir=/home/user/backup/$varDate
varConfigDir=/srv/docker
varOptDir=/opt/docker/homelab
varStaticDir=/mnt/storage/staticfiles

# Formatting
C_COMPOSE="\e[48;5;26m"
C_ZIP="\e[48;5;220m"
C_EOL="\e[0m"


mkdir -p $varBackupDir/$varDate
cd $varBackupDir/$varDate

# Attempt to document image tags, ports, and other container configuration
echo Backing up Docker outputs (tags, ports, names)...
docker ps > docker-ps.txt
docker image ls > docker-image-ls.txt

# Database backups (must be done while containers are still running...)
echo Backing up Databases...
sudo docker exec -t tandoor_db pg_dumpall -U tandoor_user > tandoor_pgdump.sql
sudo docker exec -t paperless_db pg_dumpall -U paperless_app > paperless_pgdump.sql


# Stop Docker for safety
echo -e "${C_COMPOSE}Shutting Containers Down...${C_EOL}"

cd $varOptDir/services/adblock-and-dns && docker compose down # pihole and unbound
cd $varOptDir/services/change-detect && docker compose down # change-detection.io and chrome
cd $varOptDir/services/dashboard && docker compose down # homepage
cd $varOptDir/services/downloads && docker compose down # *arr
cd $varOptDir/services/events && docker compose down # Rallly
cd $varOptDir/services/gloomhaven && docker compose down # GHS
cd $varOptDir/services/image-board && docker compose down # Pinry
cd $varOptDir/services/media-request && docker compose down # Jellyseerr
cd $varOptDir/services/media-streaming && docker compose down # Jellyfin
cd $varOptDir/services/monitor && docker compose down # uptime kuma, dozzle, diun, speedtracker
cd $varOptDir/services/paperless && docker compose down # paperless
cd $varOptDir/services/public && docker compose down # Caddy and Duckdns
cd $varOptDir/services/recipes && docker compose down # Tandoor
cd $varOptDir/services/security && docker compose down # Endlessh, Crowdsec


# Docker config backups
echo Backing up Docker Configs...
printf "[                  ] 0/18\r"

mkdir -p $varBackupDir/$varDate/changedetection
varTempChangeDetectionBackup=$(ls -Art $varConfigDir/changedetection/*.zip | tail -n 1)
cp -rpi $varTempChangeDetectionBackup $varBackupDir/$varDate/changedetection
printf "[#                 ] 1/18\r"

mkdir -p $varBackupDir/$varDate/ghs && cp -rpi $varConfigDir/ghs/ghs.sqlite $varBackupDir/$varDate/ghs
printf "[##                ] 2/18\r"

mkdir -p $varBackupDir/$varDate/homepage && cp -rpi $varConfigDir/homepage/*.yaml $varBackupDir/$varDate/homepage
printf "[###               ] 3/18\r"

mkdir -p $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/config $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/data $varBackupDir/$varDate/jellyfin
cp -rpi $varConfigDir/jellyfin/root $varBackupDir/$varDate/jellyfin
printf "[####              ] 4/18\r"

mkdir -p $varBackupDir/$varDate/jellyseerr
cp -rpi $varConfigDir/jellyseerr/db $varBackupDir/$varDate/jellyseerr
cp -rpi $varConfigDir/jellyseerr/settings.json $varBackupDir/$varDate/jellyseerr
printf "[#####             ] 5/18\r"


# the *arr containers smartly have scheduled backups. So we pull only the most recent to save disk space
mkdir -p $varBackupDir/$varDate/prowlarr
varTempProwlarrBackup=$(ls -Art $varConfigDir/prowlarr/Backups/scheduled | tail -n 1)
cp -rpi $varConfigDir/prowlarr/Backups/scheduled/$varTempProwlarrBackup $varBackupDir/$varDate/prowlarr
printf "[######            ] 6/18\r"

mkdir -p $varBackupDir/$varDate/lidarr
varTempRadarrBackup=$(ls -Art $varConfigDir/lidarr/Backups/scheduled | tail -n 1)
cp -rpi $varConfigDir/lidarr/Backups/scheduled/$varTempRadarrBackup $varBackupDir/$varDate/lidarr
printf "[#######           ] 7/18\r"

mkdir -p $varBackupDir/$varDate/radarr3
varTempRadarrBackup=$(ls -Art $varConfigDir/radarr3/Backups/scheduled | tail -n 1)
cp -rpi $varConfigDir/radarr3/Backups/scheduled/$varTempRadarrBackup $varBackupDir/$varDate/radarr3
printf "[########          ] 8/18\r"

mkdir -p $varBackupDir/$varDate/sonarr
varTempSonarrBackup=$(ls -Art $varConfigDir/sonarr/Backups/scheduled | tail -n 1)
cp -rpi $varConfigDir/sonarr/Backups/scheduled/$varTempSonarrBackup $varBackupDir/$varDate/sonarr
printf "[#########         ] 9/18\r"

mkdir -p $varBackupDir/$varDate/qbittorrent
cp -rpi $varConfigDir/qbt/qBittorrent/qBittorrent.conf $varBackupDir/$varDate/qbittorrent
printf "[##########        ] 10/18\r"

mkdir -p $varBackupDir/$varDate/gluetun
cp -rpi $varConfigDir/gluetun/servers.json $varBackupDir/$varDate/gluetun
printf "[###########       ] 11/18\r"

mkdir -p $varBackupDir/$varDate/pihole && cp -rpi $varConfigDir/pihole $varBackupDir/$varDate
# the below databases are very large and can be rebuilt
rm $varBackupDir/$varDate/pihole/pihole/gravity.db
rm $varBackupDir/$varDate/pihole/pihole/gravity_old.db
rm $varBackupDir/$varDate/pihole/pihole/pihole-FTL.db
printf "[############      ] 12/18\r"

mkdir -p $varBackupDir/$varDate/pinry
cp -rpi $varConfigDir/pinry/*.* $varBackupDir/$varDate/pinry
printf "[#############     ] 13/18\r"

mkdir -p $varBackupDir/$varDate/podgrab
cp -rpi $varConfigDir/podgrab/podgrab.db $varBackupDir/$varDate/podgrab
varTempPodgrabBackup=$(ls -Art $varConfigDir/podgrab/backups | tail -n 1)
cp -rpi $varConfigDir/podgrab/backups/$varTempPodgrabBackup $varBackupDir/$varDate/podgrab/backups
printf "[##############    ] 14/18\r"

mkdir -p $varBackupDir/$varDate/ripping && cp -rpi $varConfigDir/ripping $varBackupDir/$varDate
printf "[###############   ] 15/18\r"

mkdir -p $varBackupDir/$varDate/scrutiny && cp -rpi $varConfigDir/scrutiny $varBackupDir/$varDate
printf "[################  ] 16/18\r"

mkdir -p $varBackupDir/$varDate/unbound && cp -rpi $varConfigDir/unbound $varBackupDir/$varDate
printf "[################# ] 17/18\r"

mkdir -p $varBackupDir/$varDate/uptime-kuma
cp -rpi $varConfigDir/uptime-kuma/kuma.db $varBackupDir/$varDate/uptime-kuma
printf "[##################] 18/18\r"

printf "\n"


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


# Zip file
echo -e "${C_ZIP}Creating Primary Zip...${C_EOL}"
cd $varBackupDir
du -h --max-depth=1 $varDate | sort -hr
zip -r -9 $varDate $varDate > /dev/null 2>&1


####################
# Large File Storage Backups
####################

echo Backing Up Pinry: Media
mkdir -p $varBackupDir/$varDate-pinry
cp -rpi $varConfigDir/pinry/static/media $varBackupDir/$varDate-pinry
echo -e "${C_ZIP}Creating Pinry Media Zip...${C_EOL}" #testing this
cd $varBackupDir
zip -r -9 $varDate-pinry $varDate-pinry > /dev/null 2>&1


echo Backing Up Paperless: Classification Model...
mkdir -p $varBackupDir/$varDate-paperless/paperless
cp -rpi $varConfigDir/paperless/classification_model.pickle $varBackupDir/$varDate-paperless/paperless
cp -rpi $varConfigDir/paperless/index $varBackupDir/$varDate-paperless/paperless/index
echo -e "${C_COMPOSE}Starting Paperless...${C_EOL}"
cd $varOptDir/services/paperless && docker compose up -d # paperless
echo Backing Up Paperless: Documents...
sudo docker exec paperless document_exporter /usr/src/paperless/export --zip #location is within paperless container
varTempPaperlessBackup=$(ls -Art /home/user/backup/paperless | tail -n 1) # grab the most recent zip from the volume-mapped directory. Must align with your .env BACKUPDIR
cp -rpi /home/user/backup/paperless/$varTempPaperlessBackup $varBackupDir/$varDate-paperless/documents.zip
echo -e "${C_ZIP}Creating Paperless Zip...${C_EOL}"
cd $varBackupDir
zip -r -9 $varDate-paperless $varDate-paperless > /dev/null 2>&1



####################
# Cleanup
####################
echo Cleaning up...
rm -rf $varBackupDir/$varDate
rm -rf $varBackupDir/$varDate-pinry
rm -rf $varBackupDir/$varDate-paperless
#rm /home/user/backup/paperless/*.* #cleanup


# start docker again. Note, specific profiles may need restarted manually
echo -e "${C_COMPOSE}Starting Docker Containers...${C_EOL}"

cd $varOptDir/services/adblock-and-dns && docker compose up -d # pihole and unbound
cd $varOptDir/services/change-detect && docker compose up -d # change-detection.io and chrome
cd $varOptDir/services/dashboard && docker compose up -d # homepage
cd $varOptDir/services/downloads && docker compose up -d # *arr
cd $varOptDir/services/events && docker compose up -d # Rallly
cd $varOptDir/services/gloomhaven && docker compose up -d # GHS
cd $varOptDir/services/image-board && docker compose up -d # Pinry
cd $varOptDir/services/media-request && docker compose up -d # Jellyseerr
cd $varOptDir/services/media-streaming && docker compose up -d # Jellyfin
cd $varOptDir/services/monitor && docker compose up -d # uptime kuma, dozzle, diun, speedtracker
cd $varOptDir/services/public && docker compose up -d # Caddy and Duckdns
cd $varOptDir/services/recipes && docker compose up -d # Tandoor
cd $varOptDir/services/security && docker compose up -d # Endlessh, Crowdsec