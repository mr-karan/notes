A little while ago, I'd to extract the filename (without the extension) from a particular JSON file. There'a a neat [`basename`](https://man7.org/linux/man-pages/man1/basename.1.html) utility that I didn't know about.

However, it cannot accept STDIN so if you're using it with `pipes`, you need to use `xargs`.

## Get the filename with extension

```bash
cat ~/app.json | jq '.file_path' | xargs basename
```

## Remove the extension

```bash
cat ~/app.json | jq '.file_path' | xargs basename  -s .txt
```


