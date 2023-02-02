## Remove images locally with a wildcard:

```
docker rmi --force $(docker images | grep <image-name> | tr -s ' ' | cut -d ' ' -f 3) `
```

## Remove images using xargs

I wanted to remove all containers that had the word `outline` in their name. I used the following command:

```
docker ps | grep outline | awk '{print $1}' | xargs docker rm -f
```

## Dockerhub Rate Limits

```
TOKEN=$(curl "https://auth.docker.io/token?service=registry.docker.io&scope=repository:ratelimitpreview/test:pull" | jq --raw-output .token) && curl --head --header "Authorization: Bearer $TOKEN" "https://registry-1.docker.io/v2/ratelimitpreview/test/manifests/latest" 2>&1 | grep ratelimit
```

## Docker Disk Usage

```
docker system df --verbose
```

## Stop all containers


```
docker stop $(docker ps -a -q)
```
