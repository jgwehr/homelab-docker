## Correct unbound.conf
- access-control: 192.168.1.0/24 allow
- private-address: 192.168.1.0/24
- #private domains


## Copy Files
copy: `a-records.conf` to `${CONFIGDIR}/unbound/a-records.conf`
copy: `unbound.conf` to `${CONFIGDIR}/unbound/unbound.conf`
copy: `root.hints` to `${CONFIGDIR}/unbound/root.hints`