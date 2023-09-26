#!/bin/bash

source installations/install.sh
source installations/git_packages.sh
source parachain/index.sh

if [ "$#" -ne 3 ]; then
  echo "Usage: ./run_parachain.sh <parachain_git_url> <binary_name> <binary_json_chain_spec>"
  exit 1
fi

$git_url=$1
$binary_name=$2
$parachain_chain_spec=$3

cd $HOME
install_linux_packages
install_rust
install_nvm
install_nodejs18

install_polkadot

install_parachain
build_parachain
link_parachain

install_and_build_zombienet

get_zombienet_config
update_zombienet_config

get_parachain_chain_spec
run_zombienet_parachain