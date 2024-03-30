## Included projects

- https://github.com/dgtlmoon/changedetection.io
- https://hub.docker.com/r/selenium/standalone-chrome/

## Dependencies

- The Chrome container is not required, but enables screenshots


## Environment and Configuration

### Ports
- `PORT_CHANGEDETECTION` - web access
- `PORT_WEBDRIVER` - for the chrome container
- `SERVER_URL` - universal. your internal url


### URLs
- `SERVER_URL` - universal. your internal url

### Functionality
- `HOMEPAGE_CHANGEDETECTION_API` - provide this to enable the widget on the Homepage dashboard. Accessible via Settings > API


### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)

## Backups
- Simply click the "backup" button on the Change Detection UI