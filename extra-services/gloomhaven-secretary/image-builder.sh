
# $1 = version tag

echo Pulling and Building latest images
docker build --rm -q --tag gloomhaven https://github.com/Lurkars/gloomhavensecretary.git#main
docker build --rm -q --tag gloomhaven-secretary https://github.com/Lurkars/ghs-server.git#main

echo Committing container images to :latest ...
docker container commit gloomhaven snoopeppers/gloomhaven-secretary:latest >/dev/null 2>&1
docker container commit gloomhaven-server snoopeppers/gloomhaven-secretary-server:latest >/dev/null 2>&1

echo Committing container images to :$1 ...
docker container commit gloomhaven snoopeppers/gloomhaven-secretary:$1 >/dev/null 2>&1
docker container commit gloomhaven-server snoopeppers/gloomhaven-secretary-server:$1 >/dev/null 2>&1

echo
docker image ls | grep gloomhaven-secretary
echo

echo Pushing images to DockerHub...
docker image push --all-tags snoopeppers/gloomhaven-secretary
docker image push --all-tags snoopeppers/gloomhaven-secretary-server