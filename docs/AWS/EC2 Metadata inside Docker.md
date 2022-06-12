If you try to access EC2 Metadata endpoint from a Docker container which is bridged to the default network interface on your host, you would assume things to _just_ work, right? Wrong.

Here's what happens when you do this command on the host (it works fine):

```bash
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/
```

Here's what happens when you do it inside a container:
```bash
docker run --rm -it alpine:sh
apk add bash curl

TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/
```

It is stuck and will eventually time out.

## The Fix

This is because the response comes with a packet of **TTL as 1**. (TTL at packet level means number of hops). Since this response has to eventually pass to your container, you need to increase it higher. (For eg, 3 is fine).

[Refer to docs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html)
> By default, the response to `PUT` requests has a response hop limit (time to live) of `1` at the IP protocol level. You can adjust the hop limit using the `modify-instance-metadata-options` command if you need to make it larger. For example, you might need a larger hop limit for backward compatibility with container services running on the instance. For more information, see [modify-instance-metadata-options](https://docs.aws.amazon.com/cli/latest/reference/ec2/modify-instance-metadata-options.html) in the _AWS CLI Command Reference_.

There's a nice read on how `traceroute` works, which kind of explains the above TTL concept as well: https://alexanderell.is/posts/toy-traceroute/

### Modifying in Terraform

Inside the `aws_instance` resource block, add this block:

```hcl
  metadata_options {
    http_put_response_hop_limit = 3
    http_endpoint               = "enabled"
  }
```