Docker uses `172.17.0.0/16` as the CIDR for it's own network and all the other bridge network it creates. It maybe sometimes useful to change the default subnet to a custom one, in case it conflitcts with other resources (like AWS VPC) in your infra.
Not just this, it can also happen if you've multiple `docker-compose` projects in your server and you face an error similar to:

```
ERROR: could not find an available, non-overlapping IPv4 address pool among the defaults to assign to the network 
```


```
$ ip a show docker0

8: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:18:b7:60:80 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:18ff:feb7:6080/64 scope link 
       valid_lft forever preferred_lft forever
```

## Docker-compose
If you're using `docker-compose`, then you can simply update the subnet for the bridge network created in that file by giving custom IPAM options in the network section of the file. 

```yml

services:
  app:
    image: app/app:latest
    networks:
      - monitor-net

networks:
  monitor-net:
    ipam:
      driver: default
      config:
        - subnet: 192.168.96.0/27
```

## Docker settings

If you wish to update the base address of `docker0` interface and define these subnets globally, you can update `daemon.json` settings.

```json
{
  "bip": "10.200.0.1/24",
  "default-address-pools":[
    {"base":"10.201.0.0/16","size":24},
    {"base":"10.202.0.0/16","size":24}
  ]
}
```

Add the following to `/etc/docker/daemon.json` 

```
sudo systemctl restart docker
```

### Verify the settings

```
ip a show docker0
```

You should see `10.200.0.1`

## Ref
- https://straz.to/2021-09-08-docker-address-pools/
- https://github.com/docker/docker.github.io/issues/8663#issuecomment-956438889
- https://serverfault.com/questions/916941/configuring-docker-to-not-use-the-172-17-0-0-range
