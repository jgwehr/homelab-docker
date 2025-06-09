# Installs the latest version of MergerFS
# Remember to do this every few months to get a fresh version of mergerfs. We aren't using the repo version here so updates are not automatic.
#   https://perfectmediaserver.com/03-installation/manual-install-proxmox/#mergerfs
#


### Downloads latest version from github for your os_release. https://perfectmediaserver.com/02-tech-stack/mergerfs/
curl -s https://api.github.com/repos/trapexit/mergerfs/releases/latest | grep "browser_download_url.*$(grep VERSION_CODENAME /etc/os-release | cut -d= -f2)_$(dpkg --print-architecture).deb\"" | cut -d '"' -f 4 | wget -qi - && sudo dpkg -i mergerfs_*$(grep VERSION_CODENAME /etc/os-release | cut -d= -f2)_$(dpkg --print-architecture).deb && rm mergerfs_*.deb

### Verify installation
apt list mergerfs