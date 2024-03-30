## Included projects

- https://github.com/benphelps/homepage

## Dependencies

- Hard dependency on the **infra** service stack, which provides the Docker Socket Proxy

## Environment and Configuration

### Files
1. Copy all files in `./configtemplates/homepage` to your config directory for homepage `${CONFIGDIR}/homepage`

### Ports

- `PORT_SOCKY_PROXY` - defined as part of **infra**
- `PORT_DASH_HTTP`


### URLs
- `SERVER_URL` - universal. your internal url

### Functionality
- You may need to alter the `SYS_DISK#` variables in `.env` and related Volume mappings in the *docker-compose* depending on your harddrive situation. Currently, I have 3 drives supported by 1 parity drive for a total of 4.
- Edit the new `widgets.yaml`. Align the `disk:` section to your Volume mappings
- Edit the new `docker.yaml`. Paste the value of `PORT_SOCKY_PROXY` into `port:`
- Refer to Homepage's documentation to customize the app beyond each of the containers; such as theme, bookmarks, etc.


### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)

## Backups
- If needed, standard backup of CONFIGDIR. The vast majority of content is provided at run time by each *docker-compose*