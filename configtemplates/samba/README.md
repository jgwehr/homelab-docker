# Functionality
Following the below steps will offer:

1. a Network share for Paperless. Files can be dropped here by unauthenticated users on your network. If paperless' CONSUME DIRECTORY is pointed to this location, it will automatically ingest files.
1. example Network Shares for movies, podcasts, and other storage. You can duplicate these to access music or anything else.

I really don't understand Samba, and permission seem to be a huge cause of issues. I wasn't able to mount a share to my retropie, for example. Regardless, this .conf works for Paperless which was the primary goal for now.


### Copy the smb.conf (optional)
`cp -rpi smb.conf /etc/samba/smb.conf`

### Modify as needed
`sudo nano /etc/samba/smb.conf`

1. customize `workgroup`. I had the best luck keeping this as "WORKGROUP"
1. customize `server string`
1. customize `interfaces`
1. customize user for `paperless`.`force user`. I still don't really get SAMBA, so this may not be necessary


### Samba Users
Do your own research, I didn't have much luck with this. 
`sudo useradd -c "RetroPie Samba User" -r samba_retropie`
`sudo passwd samba_retropie`
`sudo smbpasswd -a username`


### Restart Samba
`sudo service smbd restart`
`sudo ufw allow samba`
