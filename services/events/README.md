## Included projects

- https://github.com/lukevella/rallly
- https://github.com/docker-library/postgres

## Dependencies

- Public access via Reverse Proxy requires the `public` Service and Network
- You will need an SMTP api in order to retrieve login codes (and event updates)

## Environment and Configuration

### Files
1. Consider modifying the Caddyfile for your prefered external sub-domain. Must match `EXTERNAL_RALLLY`

### Ports

- `PORT_RALLLY`
- `PORT_RALLLY_DB`

### URLs
- `EXTERNAL_RALLLY` - how the app is exposed via Reverse Proxy to the public. You must also update the Caddyfile to match.
- `SERVER_URL` - universal. your internal url
- `DOMAIN` - universal. your public facing domain name

### Rallly's Functionality
- `RALLLY_SECRETKEY` - Generate a password with something like `openssl rand -base64 32`
- `RALLLY_ALLOWED_EMAILS` - Refer to documentation. Provide a list of valid addresses or domains to prevent randoms from registering.

The details of SMTP are beyond the scope of this project and my ability.  Please research further yourself.
- `RALLLY_SUPPORTEMAIL` - This is where Rallly's email will be sent from. 
- `RALLLY_SMTP_HOST` - Provided by your SMTP host.
- `RALLLY_SMTP_PORT` - Provided by your SMTP host.
- `RALLLY_SMTP_SECURE`
- `RALLLY_SMTP_USER` - Provided by your SMTP host.
- `RALLLY_SMTP_PASSWORD` - Provided by your SMTP host.

### Rallly's Postgres Database
- `RALLLY_DB_NAME` - shared between the database and the app
- `RALLLY_DB_USER` - shared between the database and the app
- `RALLLY_DB_PASSWORD` - shared between the database and the app. Generate a password with something like `openssl rand -base64 32`

### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)
- `DBDIR` - universal. where databases store their... databases. 

### Local Only
- Remove/Comment the Caddy-net Network
- Remove/Comment references to `EXTERNAL_RALLLY`, `DOMAIN`

## Backups
- Given the nature of this app, I don't personally back it up. But, it is just a PostGres DB and can probably be backed up with eg. `docker exec -t rallly_db pg_dumpall -U rallly_app > rallly_pgdump.sql`