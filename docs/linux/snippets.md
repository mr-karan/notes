# Common CLI commands

## rsync

### Copying files locally

```
rsync -avhW --no-compress --progress /src/ /dst/
```

### Passing SSH Extra Options

```
rsync -avzhP --stats -e 'ssh -o "Hostname <ip>"' <bastion_host>:/src/ /dst/
```

## curl

### Show only headers

curl has an option to display only headers using `-I`. This flag is better than using a combination of `-s` and redirecting the output to `/dev/null` or `2>&1` as it's easier to remember.

An important thing to note is that `-I` sends a `HEAD` request. As shown here:

```shell
$ curl -I  -vvvv https://mrkaran.dev 2>&1 | grep -C 3 'HEAD'
} [5 bytes data]
* Using Stream ID: 1 (easy handle 0x55dff1e30920)
} [5 bytes data]
> HEAD / HTTP/2
> Host: mrkaran.dev
> user-agent: curl/7.76.1
> accept: */*
```

However it's easy to override the HTTP method using `-X`. For eg, to send a `GET` request but only display the headers:

```
curl -I -X GET -vvvv https://mrkaran.dev
```

### Send a JSON payload from file

```sh
curl -i -XPOST -H "Content-Type: application/json" -d @mock_payload.json http://localhost:6000/endpoint
```

## git

### Set the editor

```sh
git config --global core.editor "vim"
```

### Delete all local branches

```sh
git branch --merged | grep -v \* | xargs git branch -D
```

## sed

### Edit in place

`sed -i 's/STRING_TO_REPLACE/STRING_TO_REPLACE_IT/g' filename`

### Match only the word

`\b` in regex is used to match word boundaries (i.e. the location between the first word character and non-word character).

`sed -i 's/\bsuper_specific_phrase\b/STRING_TO_REPLACE_IT/g' filename`

## tcpdump

### Check for packets flowing out from an interface for a specific CIDR

```bash
sudo tcpdump -v -i wlo1 dst net 192.168.0.0/16
```

- `-i` is for `interface`. `wlo1` is the interface name.
- `dst` specifies `destination IP`
- `net` specifies it's a CIDR range.

## ip

## List routing table

```sh
ip route
```

## Find which interface and route a particular IP is taking

```sh
ip route get 192.168.1.1
```
