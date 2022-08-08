## Fetch a list of `running` instances

```bash
aws ec2 describe-instances --output json | jq -r '.Reservations[].Instances[] | select(.State.Name == "running") | { instance_id: .InstanceId, instance_type: .InstanceType, private_ip: .PrivateIpAddress, name: .Tags[]|select(.Key=="Name")|.Value, env: .Tags[]|select(.Key=="env")|.Value, role: .Tags[]|select(.Key=="role")|.Value } | [.instance_id,.name,.instance_type,.private_ip,.env,.role] | @csv '
```

- Selects only running instances
- Add tags to the metadata.
- Outputs to CSV.

## Size of S3 Bucket

```bash
aws s3 ls s3://{{BUCKET_NAME}} --recursive  | grep -v -E "(Bucket: |Prefix: |LastWriteTime|^$|--)" | awk 'BEGIN {total=0}{total+=$3}END{print total/1024/1024" MB"}'
```

## Format List Output

```bash
aws s3 ls s3://mybucket --recursive --human-readable --summarize
```

## Network usage of EC2 Instance

Find out the total Network Out (in GBs) of an EC2 instance for a given time period

```bash
 aws cloudwatch get-metric-statistics --metric-name NetworkOut --start-time 2022-07-01T00:00:00.000Z --end-time 2022-08-01T00:00:00.000Z --period 86400 --namespace AWS/EC2 --statistics Sum --dimensions Name=InstanceId,Value=i-instance-id-xxx --region ap-south-1 --output text
```