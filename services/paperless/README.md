## Included projects

- https://github.com/paperless-ngx/paperless-ngx
- https://github.com/docker-library/postgres
- https://github.com/docker-library/redis

## Dependencies

- I run these services locally
- Samba can be configured to make "consuming" or ingesting documents more user-friendly


## Environment and Configuration

### Files


### Ports

- `PORT_PAPERLESS`

### URLs
- `SERVER_URL` - universal. your internal url

### Secrets
- Create a secure key for Paperless: `PAPERLESS_SECRETKEY`
- Once you've started Paperless, you may want to provide your user's credentials to Homepage: `HOMEPAGE_PAPERLESS_USERNAME` and `HOMEPAGE_PAPERLESS_PASSWORD`

### Databases
- Redis is set up to be plug and play
- PostGres database name: `PAPERLESS_DB_NAME`
- PostGres database user: `PAPERLESS_DB_USER`
- PostGres database password: `PAPERLESS_DB_PASSWORD`

### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)
- `PAPERLESS_CONSUMEDIR` - this is where you'd configure SAMBA to allow network access to. Files placed in this directory are consumed, and moved, by paperless
- `BACKUPDIR` - Document export commands go here
- `DIR_STATIC` - uploaded documents go here
- `DBDIR` - Redis and Postgres store their data here


## Backups
- Paperless has an verbose way of storing documents, with many duplicates. Read the documentation and decide what is best for you.
- Documents can be exported to your CONFIG dir using `docker exec paperless document_exporter /usr/src/paperless/export --zip`
- Backup `classification_model.pickle` if you desire, though it's not needed. This is the machine-learned way it categorizes documents.
- If you use the backup.sh script, you may need to adjust the backup script to match `PAPERLESS_DB_USER` or `PAPERLESS_DB_NAME`