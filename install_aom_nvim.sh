#! /usr/bin/env bash

# Exit on the first error
set -e

ARCH=$(uname -m)
INSTALL_DIRECTORY=~/.aom/bin

# Make our install directory if it doesn't already exist
mkdir -p $INSTALL_DIRECTORY

# Make a temporary directory to store all our downloaded files
STAGING_DIRECTORY=$(mktemp -d)

PREVIOUS_DIRECTORY=$(pwd)

# CD into our staging directory
cd $STAGING_DIRECTORY

# Install nvim using a precompiled binary

if [ $ARCH == "aarch64" ]; then
  NVIM_FILENAME=nvim-linux-arm64
else
  NVIM_FILENAME=nvim-linux-$ARCH
fi

NVIM_ARCHIVE=$NVIM_FILENAME.tar.gz

# Fetch the latest nvim from its releases page
curl -LO https://github.com/neovim/neovim/releases/latest/download/$NVIM_ARCHIVE
# Extract our fetched archive to our install directory
tar -C $INSTALL_DIRECTORY -xzf $NVIM_ARCHIVE
# Remove our archive
rm $NVIM_ARCHIVE

# Make nvim available on the PATH
echo "export PATH=\$PATH:$INSTALL_DIRECTORY/$NVIM_FILENAME/bin" >> ~/.bashrc

# Fetch my nvim config from github and install it in the nvim config directory
git clone https://github.com/andrewsomahony/nvim_config.git ~/.config/nvim

# Install ripgrep for telescope.nvim searching

# For some reason, Ripgrep only is compiled with glibc when compiled for aarch64,
# while with x86_64, it is compiled with musl
if [ $ARCH == "aarch64" ]; then
  RG_FILENAME=ripgrep-14.1.1-$ARCH-unknown-linux-gnu
else
  RG_FILENAME=ripgrep-14.1.1-$ARCH-unknown-linux-musl
fi
RG_ARCHIVE=$RG_FILENAME.tar.gz

# Fetch ripgrep from their releases page
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/$RG_ARCHIVE
# Extract our archive to our install directory
tar -C $INSTALL_DIRECTORY -xzf $RG_ARCHIVE
# Remove our ripgrep archive
rm $RG_ARCHIVE

# Make ripgrep available on the system path
echo "export PATH=\$PATH:$INSTALL_DIRECTORY/$RG_FILENAME" >> ~/.bashrc

# CD back to our previous directory
cd $PREVIOUS_DIRECTORY

# We're done!
echo "aom nvim environment successfully installed"
