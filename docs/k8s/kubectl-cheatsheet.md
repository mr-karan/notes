# Kubectl Cheatsheet

## Trigger a cronjob manually

```
kubectl create job --from=cronjob/<cronjob-name> <unique-job-name>
```

## Get events sorted by timestamp

```
kubectl get events --sort-by=.metadata.creationTimestamp
```
