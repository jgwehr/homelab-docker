
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
    # Pull the image. Build the image. Tag it to repo/container:tag
    echo Pulling and Building Client image for $1 ... \(longest step\)
    docker build --rm -q --tag $varRepo/gloomhaven-secretary:$1 https://github.com/Lurkars/gloomhavensecretary.git#$1

    # For simplicity sake, we assume we're only building the latest
    echo Committing container image to :latest ...
    docker container commit $varRepo/gloomhaven-secretary:$1 $varRepo/gloomhaven-secretary:latest >/dev/null 2>&1

    echo Pushing images to DockerHub...
    docker image push --all-tags $varRepo/gloomhaven-secretary
else
    echo Tag exist already for Client. Skipping.
fi

#skip if the image:tag already exists
if [[ -z $varImageServer ]]
then
    echo Pulling and Building Server image for $1 ... \(longest step\)
    docker build --rm -q --tag $varRepo/gloomhaven-secretary-server:$1 https://github.com/Lurkars/ghs-server.git#$1

    echo Committing container image to :latest ...
    docker container commit $varRepo/gloomhaven-secretary-server:$1 $varRepo/gloomhaven-secretary-server:latest >/dev/null 2>&1

    echo Pushing images to DockerHub...
    docker image push --all-tags $varRepo/gloomhaven-secretary-server
else
    echo Tag exist already for Server. Skipping.
fi

echo
docker image ls | grep gloomhaven-secretary
echo