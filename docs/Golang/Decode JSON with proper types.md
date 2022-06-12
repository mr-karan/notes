I had to unmarshall a `POST` body JSON payload into a `struct` but the payload had all fields as `string` and I wanted to have proper data types for the keys.

This is how the `payload` looked like:

```json
{
    "bufsize": "512",
    "class": "IN",
    "do": "false",
    "duration": "0.000072844",
    "id": "33531",
    "level": "INFO",
    "name": "mrkaran.dev.",
    "proto": "udp",
    "rcode": "NOERROR",
    "rflags": "qr,aa,rd,ra",
    "rsize": "83",
    "server_addr": "127.0.0.1",
    "server_port": "53256",
    "size": "29",
    "type": "A"
}
```

Some of the fields like `bufsize`, `size`, `id` should be of type `int32`. To decode these `string` fields into the types defined in struct, we can use `json:",string"`.

This is how the `struct` looks:

```go
type Log struct {
        BufSize    int     `json:"bufsize,string"`
        Class      string  `json:"class"`
        DO         bool    `json:"do,string"`
        Duration   float64 `json:"duration,string"`
        ID         int     `json:"id,string"`
        Level      string  `json:"level"`
        Name       string  `json:"name"`
        Proto      string  `json:"proto"`
        RCode      string  `json:"rcode"`
        RFlags     string  `json:"rflags"`
        RSize      int     `json:"rsize,string"`
        ServerAddr string  `json:"server_addr"`
        SererPort  int     `json:"server_port,string"`
        Size       int     `json:"size,string"`
        Type       string  `json:"type"`
}
```

Quoting from the [docs](https://golang.org/pkg/encoding/json/):

> The "string" option signals that a field is stored as JSON inside a JSON-encoded string. It applies only to fields of string, floating point, integer, or boolean types. This extra level of encoding is sometimes used when communicating with JavaScript programs:

