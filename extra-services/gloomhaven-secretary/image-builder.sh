
# $1 = version tag
varRepo=snoopeppers

#require a tag
if [[ -z $1 ]]
then
    echo No tag provided. Skipping.
    exit
fi

# check if the tag has already been pulled or not
varImageClient=$(docker image ls -q $varRepo/gloomhaven-secretary:$1)
varImageServer=$(docker image ls -q $varRepo/gloomhaven-secretary-server:$1)

#skip if the image:tag already exists
if [[ -z $varImageClient ]]
then
    echo Pulling and Building latest Client image
    docker build --rm -q --tag gloomhaven https://github.com/Lurkars/gloomhavensecretary.git#main

    echo Committing container image to :latest ...
    docker container commit gloomhaven $varRepo/gloomhaven-secretary:latest >/dev/null 2>&1

    echo Committing container image to :$1 ...
    docker container commit gloomhaven $varRepo/gloomhaven-secretary:$1 >/dev/null 2>&1

    echo Pushing images to DockerHub...
    docker image push --all-tags $varRepo/gloomhaven-secretary
else
    echo Tag exist already for Client. Skipping.
fi

#skip if the image:tag already exists
if [[ -z $varImageServer ]]
then
    echo Pulling and Building latest images
    docker build --rm -q --tag gloomhaven-secretary https://github.com/Lurkars/ghs-server.git#main

    echo Committing container images to :latest ...
    docker container commit gloomhaven-server $varRepo/gloomhaven-secretary-server:latest >/dev/null 2>&1

    echo Committing container images to :$1 ...
    docker container commit gloomhaven-server $varRepo/gloomhaven-secretary-server:$1 >/dev/null 2>&1

    echo Pushing images to DockerHub...
    docker image push --all-tags $varRepo/gloomhaven-secretary-server
else
    echo Tag exist already for Server. Skipping.
fi

echo
docker image ls | grep gloomhaven-secretary
echo