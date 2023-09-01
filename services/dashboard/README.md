## Included projects

- https://github.com/benphelps/homepage

## Dependencies

- Hard dependency on the **infra** service stack, which provides the Docker Socket Proxy

## Environment and Configuration

### Files
- TODO

### Ports

- `PORT_SOCKY_PROXY` - defined as part of **infra**
- `PORT_DASH_HTTP`


### URLs
- 

### Functionality
- TODO



### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)
- `STATICCONFIGDIR`
- `DBDIR` - universal. where databases store their... databases. 

## Backups
- If needed, standard backup of CONFIGDIR