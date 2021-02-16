# Docker Commands

## Remove images locally with a wildcard:

```
docker rmi --force $(docker images | grep <image-name> | tr -s ' ' | cut -d ' ' -f 3) `
```
