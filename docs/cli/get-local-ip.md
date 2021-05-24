# Find the primary IP of local machine

### Get the IP of all interfaces:

```
ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
```

### Get the IP of a specific interface:

For eg (`wlo1`):

```shell
ifconfig wlo1 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
```

[Source](https://stackoverflow.com/a/13322549)
