# Service List

I needed to fetch a list of upstream services from Nomad's service registry and render in a `.toml` file like this. This is essentially a comma separated list of services 

```toml
servers = ["1.1.1.1:53","8.8.8.8:53"]
```

Figuring this out with Go template took some time.

```go
servers = [{{ range $index, $element := nomadService "my-app-svc" }}{{if $index}},{{end}}"{{.Address}}:{{.Port}}"{{- end }}]
```
