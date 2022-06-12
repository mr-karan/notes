## Output to File

```toml
[sinks.file_out]
  # General
  type = "file" # required
  inputs = ["log_files"]
  compression = "none" # optional, default
  path = "./app-logs/access_token-%Y-%m-%d.log" # required

  # Encoding
  encoding.codec = "ndjson" # required

  # Healthcheck
  healthcheck.enabled = true # optional, default
```

## Dummy Sink

```toml
[sinks.blackhole]
  type = "blackhole"
  inputs = ["format_haproxy_logs"]
```

## Console Sink

```toml
[sinks.console_out]
  type = "console"
  inputs = ["log_files"]
  target = "stdout"
  encoding.codec = "json"
```

### CLI Commands

```bash
$ vector vrl
$ vector top
```
