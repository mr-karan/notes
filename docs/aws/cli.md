# AWS CLI snippets

## Fetch a list of `running` instances

```
aws ec2 describe-instances --output json | jq -r '.Reservations[].Instances[] | select(.State.Name == "running") | { instance_id: .InstanceId, instance_type: .InstanceType, private_ip: .PrivateIpAddress, name: .Tags[]|select(.Key=="Name")|.Value, env: .Tags[]|select(.Key=="env")|.Value, role: .Tags[]|select(.Key=="role")|.Value } | [.instance_id,.name,.instance_type,.private_ip,.env,.role] | @csv '
```

- Selects only running instances
- Add tags to the metadata.
- Outputs to CSV.
