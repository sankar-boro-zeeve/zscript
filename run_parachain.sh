#!/bin/bash

source installations/install.sh
source installations/git_packages.sh
source parachain/index.sh

cd $HOME
install_linux_packages
install_rust
install_nvm
install_nodejs18

install_polkadot

install_parachain
build_parachain
link_parachain
get_parachain_chain_spec

install_and_build_zombienet

get_zombienet_config
update_zombienet_config
run_zombienet_parachain