# Common CLI commands

## rsync

### Copying files locally

```
rsync -avhW --no-compress --progress /src/ /dst/
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