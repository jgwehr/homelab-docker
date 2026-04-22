# check thumbdrive
lsblk

# Mount
mount /dev/sdf1 /mnt/usb

# the container should be down before backing up the database
docker compose down

# [backup and zip the database](https://docs.immich.app/administration/backup-and-restore)
# Replace <DB_USERNAME> with the database username - usually postgres unless you have changed it.
sudo docker exec -t immich_postgres pg_dumpall --clean -U postgres | gzip > immich_postgres-20251116.sql.gz

# Backup Files
rsync -ahl --ignore-existing --progress /mnt/storage/photos/upload/<>/ /mnt/usb/images-joe/


# check size
du -hs /mnt/usb/sql-joe/

# unmount
umount /mnt/usb/