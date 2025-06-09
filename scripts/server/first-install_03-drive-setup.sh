# Establishes the directory structure, users, etc
# Intended for the initial set up of a server; should not be ran after success
#
#


## Drive Mounting https://perfectmediaserver.com/03-installation/manual-install-proxmox/#mountpoints
### Check Drives
inxi -xD
ls -lA /dev/disk/by-id
####  The /dev/disk/by-id identifier is tied to that specific piece of hardware by drive model and serial number and will therefore never change which is why it is recommended over using /dev/sdc.


### for Each Drive
#>>>    mkdir /mnt/<enumeratedMountPoint1>
#>>>    mount /dev/disk/by-id/<disk-by-id>-part1 /mnt/<enumeratedMountPoint1>

### Verify that the drive mounted and displays the correct size as expected
df -h


mkdir /mnt/disk{1,2,3,4} #TODO: Parameterize
mkdir /mnt/parity1 # adjust this command based on your parity setup #TODO: Parameterize

tree