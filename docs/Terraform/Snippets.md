## Get the list of AWS API actions required to run `terraform`

Terraform uses AWS APIs to modify infrastructure. To find out a set of minimal IAM policies required for `tf apply` to run, we can follow [this approach](https://stackoverflow.com/a/60542958):

- Give full permissions to your IAM user.
- Run `TF_LOG=trace terraform apply --auto-approve &> log.log`
- Run `cat log.log | grep "DEBUG: Request"`


Sometimes, the error message isn't clear by Terraform Provider.  In that case, the following command helps:

```bash
grep 'HTTP/1.1 403' -C 5 log.log
```

## Delete all resources in a state

```bash
terraform state list | cut -f 1 -d '[' | xargs -L 1 terraform state rm
```