For formatting HCLv2 files (that Nomad job spec uses), you can use the following setup to neatly format them automatically.

## VSCode

- Install this [extension](https://marketplace.visualstudio.com/items?itemName=fredwangwang.vscode-hcl-format).
- Add the following lines to your `settings.json`:

```json
    "files.associations": {
        "*.nomad": "hcl",
        "*.nomad.tpl": "hcl",
        "*.tf": "terraform",
    }
```
- Reload VSCode.

## Manual

- Install `hclfmt` using `go` (they don't provide pre-compiled binaries, so building from source is only option):

```bash
go install github.com/hashicorp/hcl/v2/cmd/hclfmt@latest
```

- Format with `hclfmt`. Since it only works on a single file by default, we need to use a wrapper script to cover all files and nested directories.

```bash
#!/usr/bin/env bash
set -e
for file in *; do
  hclfmt -w $file
done
```

- Save the above as `run-hclfmt` in `/usr/local/bin` and `chmod +x /usr/local/bin/run-hclfmt`

- Now, you'll be able to run this script from anywhere in your directory of Nomad job specs using `run-hclfmt`. It includes sub directories as well.

