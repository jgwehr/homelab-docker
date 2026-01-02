## Included projects

- https://github.com/karakeep-app/karakeep
- https://github.com/ollama/ollama
- https://github.com/meilisearch/meilisearch
- https://hub.docker.com/r/zenika/alpine-chrome/tags

## Dependencies

- This app runs LLMs for various purposes; sufficient RAM, CPU, and disk space are required to host and run this efficiently


## Environment and Configuration

### Setup
1. Start the Ollama container first. Then, choose your [text](https://ollama.com/search?c=tools) and [visual](https://ollama.com/search?c=vision) models. For each of these, run `ollama pull <>` within the container

### Files
n/a

### Ports
- `PORT_KARAKEEP`
- `PORT_KARAKEEP_CHROME`
- `PORT_OLLAMA`

### URLs
- `SERVER_URL` - universal. your internal url


### Data and Backups
- `CONFIGDIR` - universal. where the containers store their configuration data (aka Volume)
- `DIR_AI` - LLM storage
- `DIR_DB` - Karakeep's database
- `DIR_DOCUMENT` - Karakeep downloads (such as images)

### Local Only
n/a

## Backups
- tbd: Karakeep DB and DOCUMENT are most importantt