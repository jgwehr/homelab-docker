# Secures SSH
# Intended for the initial set up of a server; should not be ran after success
#
# WARNING! You must first generate a Client Private/Public Key. This needs to be installed on the Server or you will lose SSH access



## SSH

### On your client, generate a private and public key:
#>>>    ssh-keygen -t ed25519
#### Use the default name. Provide a passphrase
#### Copy the contents of your public key
#### SSH into the server
#### Paste your Public Key into ~/.ssh/authorized_keys


### Restrict SSH to selected Groups/Users
groupadd -g 1022 ssh_allowed #https://linuxhandbook.com/ssh-hardening-tips/#6-allow-ssh-access-to-selected-users-only

### Add users to this SSH Group
usermod -a -G ssh_allowed <user> # TODO: parameterize

### Since the private key should identify a specific user it is necessary that other users on the same shared resource cannot read or manipulate the private key, i.e. the minimum permissions should allow read and write access only for the user itself
chmod 600 ~/.ssh/authorized_keys


###  SSHD Config steps
nano /etc/ssh/sshd_config # Open SSHD Config

### MANUAL: Modify sshd_confi with the following:
#>>>    PermitEmptyPasswords no
#>>>    PasswordAuthentication no
#>>>    Port <portNumber> # TODO: parameterize
#>>>    PermitRootLogin no
#>>>    Protocol 2
#>>>    ClientAliveInterval 1800 # 30 minutes time out
#>>>    ClientAliveCountMax 2
#>>>    AllowGroups ssh_group
#>>>    X11Forwarding no

### see all the parameters of your SSH server
sshd -T
sudo systemctl restart ssh
