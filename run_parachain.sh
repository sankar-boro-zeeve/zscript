#!/bin/bash

source installations/install.sh
source installations/git_packages.sh
source run/parachain.sh

# cd $HOME
# install_linux_packages
# install_rust
# install_nvm
# install_nodejs18
# install_polkadot
# install_zombienet

get_parachain_chain_spec
run_zombienet