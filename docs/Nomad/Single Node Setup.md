I use the following server/client config to quickly prototype Nomad jobs:


```hcl
datacenter = "dc1"
data_dir = "/opt/nomad/data"

log_level = "DEBUG"

bind_addr = "0.0.0.0"

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled = true
  
  reserved {
    cores          = 2
    memory         = 1024
    disk           = 1024
    reserved_ports = "22"
  }

  meta {
    env   = "dev"
    stack = "personal"
  }
}

plugin "docker" {
  config {
    allow_privileged = true
    volumes {
      enabled = true
    }
    extra_labels = ["job_name", "job_id", "task_group_name", "task_name", "namespace", "node_name", "node_id"]
  }
}

plugin "raw_exec" {
  config {
    enabled = true
  }
}
```

Save the file as `nomad.hcl` (which will be referenced later).

## Instructions

- Get Nomad from https://learn.hashicorp.com/tutorials/nomad/get-started-install.

- Run the local agent:

```
sudo nomad agent -config=nomad.hcl
```

- Check node status

```
nomad node status
```

- Run example deployment

```
nomad init
nomad run example.nomad
```