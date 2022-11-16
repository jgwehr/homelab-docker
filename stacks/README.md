This folder exists to separate infrequently-used or "odds and ends" out from the core services.

While not ideal from an environment variable management standpoint, it's what works for now.

The main concern is port reservation. This README also serves as documentation to avoid conflict. You can of course changes these.

### Ports

| Service               | Directory                 | Ports |
| :--                   | :--                       | :-: |
| Auto Ripping Machine  | auto-ripping-machine      | `7010` |
| Gloomhaven, Client    | gloomhaven-secretary      | `7020` |
| Gloomhaven, Server    | gloomhaven-secretary      | `7021` |