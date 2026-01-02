# the container should be down before backing up the database
docker compose down

# [backup and zip the database](https://docs.immich.app/administration/backup-and-restore)
# Replace <DB_USERNAME> with the database username - usually postgres unless you have changed it.
docker exec -t immich_postgres pg_dumpall --clean --if-exists --username=<DB_USERNAME> | gzip > "/path/to/backup/dump.sql.gz"

# Backup Files
## /mnt/storage/photos/upload\
rsync -avhl --progress --existing /mnt/storage/photos/upload/<user-id>/ /mnt/usb/