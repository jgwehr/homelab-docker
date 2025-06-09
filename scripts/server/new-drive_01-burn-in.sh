






mkdir ~/server/disk-burn-in
mkdir ~/server/disk-burn-in/logs
touch ~/server/disk-burn-in/logs/wget.log
wget -a ~/server/disk-burn-in/logs/wget.log --backups=2 -q https://github.com/Spearfoot/disk-burnin-and-testing/blob/master/disk-burnin.sh