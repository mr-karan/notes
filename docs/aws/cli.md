# AWS CLI snippets

## Fetch a list of `running` instances

```sh
aws ec2 describe-instances --output json | jq -r '.Reservations[].Instances[] | select(.State.Name == "running") | { instance_id: .InstanceId, instance_type: .InstanceType, private_ip: .PrivateIpAddress, name: .Tags[]|select(.Key=="Name")|.Value, env: .Tags[]|select(.Key=="env")|.Value, role: .Tags[]|select(.Key=="role")|.Value } | [.instance_id,.name,.instance_type,.private_ip,.env,.role] | @csv '
```

- Selects only running instances
- Add tags to the metadata.
- Outputs to CSV.

## Size of S3 Bucket

```sh
aws s3 ls s3://{{BUCKET_NAME}} --recursive  | grep -v -E "(Bucket: |Prefix: |LastWriteTime|^$|--)" | awk 'BEGIN {total=0}{total+=$3}END{print total/1024/1024" MB"}'
```
