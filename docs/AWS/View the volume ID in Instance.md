A handy command to view the EBS Volume ID in the EC2 instance is:

```
lsblk -o +SERIAL
```

Super useful when you've 2 similar size EBS volumes attached to the instance and you want to modify/resize one of them.
