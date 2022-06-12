Official guides to troubleshoot common issues:

- https://github.com/aws/amazon-vpc-cni-k8s/blob/master/docs/troubleshooting.md
- https://aws.amazon.com/premiumsupport/knowledge-center/eks-failed-create-pod-sandbox/

One of the most common issue is **getting out of available IPs in the subnet pool**. You can check the logs here:

```sh
kubectl -n kube-system exec -it aws-node-XXX-- tail -f /host/var/log/aws-routed-eni/ipamd.log | tee ipamd.log
```

Next, go to the subnet and check the available IPs. Quite likely it'll be 0. Add some kind of pod affinity to schedule the pod on another subnet using (`.spec.affinity` section of `Pod` config)

```yml
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: topology.kubernetes.io/zone
                operator: In
                values:
                - ap-south-1b

```

Here, the affinity is towards 1b node when the pod is scheduled. You can see all the different kind of Node labels/selectors applied using `kubectl describe node | grep topology`

You can even label certain nodes, and then use Node selectors instead of `affinity` to guarantee scheduling only on those selectors.