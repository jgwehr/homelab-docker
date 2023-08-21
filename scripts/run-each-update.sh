####################
# .env Management
####################

# This command alarmed me at first. There's a lot going on that isn't obvious to new linux users
#   1. `find` attempts to discover all of the directores we **want to copy the .env into**. For my purposes, this is all the "modular" docker-compose files
#   2. ALERT!!!! `/opt/docker/this-repo/` BE CAREFUL AND MODIFY THIS. The directory is tricky here. I can't know where (a) you're running the command or (b) where you've stored these docker files. 
#       You should change this to be absolute (preferred) when you know where you're hosting the repo. Ex. /opt/docker/this-repo/service/
#       Otherwise, I ASSUME you're running this script in the scripts/ directory. So, we use ../ to traverse backwards and then into the service/ directory. If you do NOT run this from scripts/ then you're in for a headache.
#   3. `-mindepth 1 -maxdepth 1` simply controls how deep into the tree we look. 
#   4. `-type d` only looks for directories (ie. all directories in services/)
#   5. `-exec ln -sbf ~/test-cmd/.env {}/.env` this has several steps:
#       5.1 `-exec` executes a command against ALL of the rows the `find` cmd returns. In our case, this should be all the matching directors exactly 1 level within ../service
#       5.2 `ln -sbf` attempts to create a (s)ymbolic link. If a file with the same name already exists, it (b) backups that file to file-name.ext~. The new file is (f)orced to be created, meaning it doesn't fail if a file already exists
#       5.3 ALERT!!!! `ln -sbf ~/test-cmd/.env {}/.env \;` BE CAREFUL AND MODIFY THIS. This creates a new symbolic link of shape ".env" using whatever file exists at "../.env". In simple terms, it takes our primary .env file and copies it into each directory. Except, as a symbolic link, it doesn't need to be "copied again".

varMainDir=/opt/docker/homelab

find $varMainDir/services -mindepth 1 -maxdepth 1 -type d -exec ln -sbf $varMainDir/.env {}/.env \;

# Now, remove the .env~ files
find $varMainDir/services -mindepth 1 -maxdepth 1 -type d -exec rm -fI {}/.env~ \;
