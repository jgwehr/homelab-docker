## Included projects

- https://github.com/TandoorRecipes/recipes
- https://hub.docker.com/_/postgres/

## Dependencies

- These services can run locally. Various Networks and dependencies can be removed if you only want local access.
- I've been able to get the images for recipes to work, but only through Reverse Proxy (or local, but not both)
- Public access via Reverse Proxy requires the `public` Service and Networks


## Environment and Configuration

### Files
1. `services\recipes\staticconfig\tandoor.env.template` should be copied to `tandoor.env` in the same directory. Follow the Tandoor Recipes install guide for best results.
1. Consider modifying the Caddyfile for your prefered external sub-domain. Must match `EXTERNAL_TANDOOR`

### Ports

- `PORT_TANDOOR`
- `POSTGRES_PORT` (within `tandoor.env`). You may need to change this if you have several PostGres instances

### URLs
- `EXTERNAL_TANDOOR` - how the client is exposed via Reverse Proxy to the public. You must also update the Caddyfile to match.
- `DOMAIN` - universal. your public facing domain name

### Tandoor's Postgres Database and Functionality
Within `services\recipes\staticconfig\tandoor.env`:
1.  `SECRET_KEY` - Generate a password with something like `openssl rand -base64 32`
1.  `POSTGRES_PASSWORD` - shared between the database and the app. Generate a password with something like `openssl rand -base64 32`

### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)
- `DBDIR` - universal. where the containers store their databases
- `DIR_STATIC` - universal. Tandoor will store uploaded images here

### Local Only
- TBD

## Backups
1. Backup Tandoor DB according to their instructions. Currently, this suggests: `sudo docker exec -t tandoor_db pg_dumpall -U tandoor_user > tandoor_pgdump.sql`
1. Backup Tandoor images etc via the static media directory: {DIR_STATIC}