Some common commands which are used to interact with the jobs/allocations.

Please refer to [CLI Docs](https://www.nomadproject.io/docs/commands) to see the common Environment Variables to use in case you're accessing a production Nomad cluster.

- Create a deployment

```bash
nomad job run file.nomad
```

- Stop a job

```bash
nomad job stop -purge <job-name>
```

- View job status

```bash
nomad job status <job-name>
```

- View `alloc` status

```bash
nomad alloc status -stats <alloc-id>
```

- View logs

```bash
nomad alloc logs -f -stderr <alloc-id>
```

- Exec inside `alloc`

```bash
nomad alloc exec -i -t -task <task-name> <alloc-id> /bin/bash
```
