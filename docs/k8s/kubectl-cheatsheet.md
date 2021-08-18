# Kubectl Cheatsheet

## Trigger a cronjob manually

```sh
kubectl create job --from=cronjob/<cronjob-name> <unique-job-name>
```

## Get events sorted by timestamp

```sh
kubectl get events --sort-by=.metadata.creationTimestamp
```

## Taint a node


```sh
kubectl taint nodes {{name}} key1=value1:NoSchedule
```

### Untaint a node

```sh
kubectl taint nodes {{name}} key1=value1:NoSchedule-
```