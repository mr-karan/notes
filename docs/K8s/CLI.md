## Trigger a cronjob manually

```bash
kubectl create job --from=cronjob/<cronjob-name> <unique-job-name>
```

## Get events sorted by timestamp

```bash
kubectl get events --sort-by=.metadata.creationTimestamp
```

## Taint a node


```bash
kubectl taint nodes {{name}} key1=value1:NoSchedule
```

### Untaint a node

```bash
kubectl taint nodes {{name}} key1=value1:NoSchedule-
```

## Resource Utilisation

### Check Resource Requests/Limits on each node

In case you need to check how much of Resource Requests/Limits are made across all the nodes in the cluster, following command is helpful:

```bash
alias util='kubectl get nodes --no-headers | awk '\''{print $1}'\'' | xargs -I {} sh -c '\''echo {} ; kubectl describe node {} | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo '\'''
```

Outputs:

```bash
ip-192-x-x-x
  Resource                    Requests      Limits
  cpu                         14472m (91%)  21970m (138%)
  memory                      21Gi (35%)    33070Mi (54%)

ip-192-x-x-x
  Resource                    Requests       Limits
  cpu                         14632m (92%)   21695m (136%)
  memory                      27448Mi (45%)  46854Mi (77%)

ip-192-x-x-x
  Resource                    Requests       Limits
  cpu                         15297m (96%)   22445m (141%)
  memory                      18819Mi (31%)  36278Mi (60%)
```
