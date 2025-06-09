apt update
apt install zfsutils-linux
whereis zfs

ls -lA /dev/disk/by-id
# Copy the appropriate drives' ids


zpool create soul1 mirror -m /mnt/soul1 -o ashift=12 /dev/disk/by-id/ata-ST8000VN004-3CP101_WWZ8Z34H /dev/disk/by-id/ata-ST8000VN004-3CP101_WWZ8Z8XS

zfs set compression=lz4 soul1

zfs create soul1/photos
zfs create soul1/documents

zpool status

zpool list

zfs mount

# Update docker .env
# Update Scrutiny, docker
# Update Homepage, docker
# Update Homepage, /srv/


# if needed, copy things to the new zfs pool
#   This is a multi-step process. First, copy to ZFS.
#   Then, the original non-ZFS storage is deleted
#   Then, Merger FS and fstab are updated.
#       The old directories are removed (or, in my case, just no longer merged from the old disks)
#       The new, ZFS directory is added
#
#   Result is that the files remain available via /mnt/storage. But the underlying data store is now ZFS.

# copy paperless docs
cp -rp /mnt/storage/staticfiles/paperless /mnt/zfspool1/documents/paperless

# If copying/migrating to the ZFS pool, then you'll want to remove the files from the original location



# then fstab. 


