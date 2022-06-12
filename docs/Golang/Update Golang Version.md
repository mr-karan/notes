The below shell script is helpful to grab a specific Go version and update it locally.

To use it you can tweak the following variables:

- `VERSION`
- `PLATFORM`

```bash
#! /bin/bash
set -euf -o pipefail

# Download latest Golang release for AMD64
# https://golang.org/dl/

VERSION=1.16
PLATFORM=linux-amd64

# Download Go
cd `mktemp -d`
echo "Downloading Go version ${VERSION}..."
curl -sL -o go${VERSION}.${PLATFORM}.tar.gz https://golang.org/dl/go${VERSION}.${PLATFORM}.tar.gz

# Remove old Go
echo "Removing old Go version"
sudo rm -rf /usr/local/go

# Install new Go
sudo tar -C /usr/local -xzf go"${VERSION}".${PLATFORM}.tar.gz
echo "Creating the skeleton for your local users go directory..."
mkdir -p ~/go/{bin,pkg,src}
# echo "Setting up GOPATH"
# echo "export GOPATH=~/go" >> ~/.profile && source ~/.profile
# echo "Setting PATH to include golang binaries"
# echo "export PATH='$PATH':/usr/local/go/bin:$GOPATH/bin" >> ~/.profile && source ~/.profile

# Cleanup
rm go"${VERSION}".${PLATFORM}.tar.gz
```

## First Time

If you're installing for the first time, you can uncomment this blob from the above script:

```bash
# echo "Setting up GOPATH"
# echo "export GOPATH=~/go" >> ~/.profile && source ~/.profile
# echo "Setting PATH to include golang binaries"
# echo "export PATH='$PATH':/usr/local/go/bin:$GOPATH/bin" >> ~/.profile && source ~/.profile
```

Mofified it from a gist I found [here](https://gist.github.com/Zate/b3c8e18cbb2bbac2976d79525d95f893).