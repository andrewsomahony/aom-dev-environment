#! /usr/bin/env bash

ARCH=$(uname -m)
INSTALL_DIRECTORY=$1

if [ -z $INSTALL_DIRECTORY ]; then
  INSTALL_DIRECTORY=~/.aom/bin
fi

STAGING_DIRECTORY=$(mktemp -d)

# Remove any existing installation of Go in our destination directory
rm -rf $INSTALL_DIRECTORY/go

# For some reason, Go doesn't have an archive that corresponds to the arch that is
# returned by uname -m when we are running on x86_64, so we have to check for it and
# adjust accordingly.

if [ $ARCH == "x86_64" ]; then
  GO_PACKAGE_NAME=go1.24.3.linux-amd64.tar.gz
elif [ $ARCH == "aarch64" ]; then
  GO_PACKAGE_NAME=go1.24.3.linux-arm64.tar.gz
else
  GO_PACKAGE_NAME=go1.24.3.linux-$(ARCH).tar.gz
fi

# Download the latest Go version into a staging directory

PREVIOUS_DIRECTORY=$(pwd)
cd $STAGING_DIRECTORY
curl -OL https://go.dev/dl/$GO_PACKAGE_NAME

# Extract our tarball to the install directory
tar -C $INSTALL_DIRECTORY -xzf $GO_PACKAGE_NAME

echo "export PATH=\$PATH:$INSTALL_DIRECTORY/go/bin" >> $HOME/.bashrc

# We're done!
cd $PREVIOUS_DIRECTORY
