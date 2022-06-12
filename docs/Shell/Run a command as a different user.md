Here's an example of running `echo` but as a `consul` user:

```bash
sudo -H -u consul bash -c 'echo "I am $USER, with uid $UID"' 
```