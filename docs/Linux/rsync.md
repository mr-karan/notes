## Copying files locally

```
rsync -avhW --no-compress --progress /src/ /dst/
```

## Passing SSH Extra Options

```
rsync -avzhP --stats -e 'ssh -o "Hostname <ip>"' <bastion_host>:/src/ /dst/
```
