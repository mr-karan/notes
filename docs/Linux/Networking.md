## tcpdump

### Check for packets flowing out from an interface for a specific CIDR

```bash
sudo tcpdump -v -i wlo1 dst net 192.168.0.0/16
```

Explanation:

- `-i` is for `interface`. `wlo1` is the interface name.
- `dst` specifies `destination IP`
- `net` specifies it's a CIDR range.

## ip

### List routing table

```bash
ip route
```

### Find which interface and route a particular IP is taking

```bash
ip route get 192.168.1.1
```


## ifconfig

### Find the primary IP of local machine

#### Get the IP of all interfaces:

```
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
```

#### Get the IP of a specific interface:

For eg (`wlo1`):

```bash
ifconfig wlo1 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
```

[Source](https://stackoverflow.com/a/13322549)
