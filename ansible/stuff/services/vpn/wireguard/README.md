# WireGuard

## Common config
```
ansible-playbook playbook-services.yml -i hosts.ini --tags="wireguard-keys-generate"
```
### Manual Config
```
ansible-playbook playbook-services.yml -i hosts.ini --tags="wireguard-install,wireguard-keys-distribute,wireguard-configure-manual"
```

### Automatic config
```  
ansible-playbook playbook-services.yml -i hosts.ini --tags="wireguard-install,wireguard-keys-distribute,wireguard-configure-automate"
```

#### Config verification
```
Verfication
ping 10.0.0.1 -> VM1
ping 10.0.0.2 -> VM2
```
#### Common utils
```
wg
wg show
wg showconf wg0
```

##### Automatic utils
```
wg-quick up <name> e.g.  wg-quick up wg0
wg-quick down wg0
```

###### Example configs
```
[root@vm-0 ~]# wg showconf wg0
[Interface]
ListenPort = 51820
PrivateKey = uPOaMjfsy+0NklP/9rUxtqHBxEvpBJljKREkJp4o4Vo=

[Peer]
PublicKey = lt5rWLmPxwsOmhONl/MWaTGBxNBabY38KHnA7N6sKQ0=
AllowedIPs = 10.0.0.2/32
Endpoint = 10.157.52.175:51820

--------------------------------------------------------
[root@vm-1 ~]# wg showconf wg0
[Interface]
ListenPort = 51820
PrivateKey = iBsYwAikv5wISfkIzY+JbL//ycGs+LnU0zvCxAK9nG4=

[Peer]
PublicKey = Mp+A0NpzbncuDTuB3V6BE/FY9AtJnaZTXHdIk9ofywM=
AllowedIPs = 10.0.0.1/32
Endpoint = 10.157.52.108:51820
```