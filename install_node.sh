#! /usr/bin/env bash

# This script installs what is required for Python and nvim to work,
# such as node for pyright and debugpy for debugging
NODE_VERSION_TO_INSTALL=22

# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# Source the NVM sh script so we get nvm, and then install our specific node version
# This installs node into the home directory, which works for us
source $HOME/.nvm/nvm.sh && nvm install $NODE_VERSION_TO_INSTALL
