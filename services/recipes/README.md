## Included projects

- https://github.com/TandoorRecipes/recipes
- https://hub.docker.com/_/postgres/

## Dependencies

- These services can run locally. Various Networks and dependencies can be removed if you only want local access.
- Public access via Reverse Proxy requires the `public` Service and Network


## Environment and Configuration

### Files
`services\recipes\staticconfig\tandoor.env.template` should be copied to `tandoor.env` in the same directory. Follow the Tandoor Recipes install guide for best results.

1.  Generate a random secret key for `SECRET_KEY`
1.  Generate a random secret key for `POSTGRES_PASSWORD`

### Ports

- `PORT_TANDOOR`
- `POSTGRES_PORT` (within `tandoor.env`). You may need to change this if you have several PostGres instances

### URLs
- `EXTERNAL_TANDOOR` - how the client is exposed via Reverse Proxy to the public. You must also update the Caddyfile to match.
- `DOMAIN` - universal. your public facing domain name

### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)
- `DBDIR` - universal. where the containers store their databases
- `STATICDIR` - universal. Tandoor will store uploaded images here

### Local Only
- Remove/Comment the Caddy-net Network
- Remove/Comment references to `EXTERNAL_GHS`, `DOMAIN`

## Backups