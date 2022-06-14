## Show only headers

curl has an option to display only headers using `-I`. This flag is better than using a combination of `-s` and redirecting the output to `/dev/null` or `2>&1` as it's easier to remember.

An important thing to note is that `-I` sends a `HEAD` request. As shown here:

```bash
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

```bash
curl -I -X GET -vvvv https://mrkaran.dev
```

## Send a JSON payload from file

```bash
curl -i -XPOST -H "Content-Type: application/json" -d @mock_payload.json http://localhost:6000/endpoint
```

## Fail if response is 4xx/5xx

Using the `--fail` flag, `curl` can detect if the response code is an error (includes 4xx,5xx with an exception for 401 and 407 as they are authentication related). This is handy to use in scripts. Read [this](https://superuser.com/a/657174) for more.

```bash
❯ curl -i --fail https://httpbin.org/status/200
HTTP/2 200 
date: Tue, 02 Nov 2021 10:43:38 GMT
content-type: text/html; charset=utf-8
content-length: 0
server: gunicorn/19.9.0
access-control-allow-origin: *
access-control-allow-credentials: true

❯ curl -i --fail https://httpbin.org/status/502
curl: (22) The requested URL returned error: 502 

❯ curl -i --fail https://httpbin.org/status/400
curl: (22) The requested URL returned error: 400 
```

## Show stats of the request

```bash
curl -kso /dev/null https://mrkaran.dev -w "==============\n\n 
| dnslookup: %{time_namelookup}\n 
| connect: %{time_connect}\n 
| appconnect: %{time_appconnect}\n 
| pretransfer: %{time_pretransfer}\n 
| starttransfer: %{time_starttransfer}\n 
| total: %{time_total}\n 
| size: %{size_download}\n 
| HTTPCode=%{http_code}\n\n"
```