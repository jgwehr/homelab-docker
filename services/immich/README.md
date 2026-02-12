## Included projects

- https://github.com/immich-app/immich
- https://github.com/postgres/postgres
- https://github.com/redis/redis

## Dependencies
- Immich requires specific versions of postgres and redis - follow their installation guide.

## Environment and Configuration

- Configure your machine learning based on your devices https://docs.immich.app/features/ml-hardware-acceleration#setup

### Files
- I only have a CPU; you can find the configuration in ./staticonfig/immich-server/hwaccel.transcoding.yml

### Ports
- `PORT_IMMICH`
- `PORT_IMMICH_ML`

### URLs
- `DOMAIN`
- `SERVER_URL` 

### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)
- `MEDIADIR` - universal. where media files (including downloads) are organized
- `DOWNLOADDIR` universal. Some apps will create content here and move/link to `MEDIADIR`. This isn't required. It's up to you (and the apps themselves) how sub directories are organized. For example, Podgrab will always go straight to `MEDIADIR` because it will only ever manage Podcasts. Metube's first stop is `DOWNLOADDIR`, though, as it can create different *kinds* of media. The *arr stack uses `DOWNLOADDIR` for different reasons: integration with qBittorrent *and* library management.
- `DBDIR` - Databases
- `DIR_PHOTOS` - Uploaded photos. I have these stored on mirrored ZFS drives
- `DIR_PHOTOS_THUMBS` - generated thumbnails will be stored here. I recommend an SSD for fast browsing


## Backups
1. Immich is actively maturing backup capabilities. Look here: https://docs.immich.app/administration/backup-and-restore#backup-ordering