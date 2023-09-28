#!/bin/bash

source installations/install.sh
source installations/git_packages.sh
source parachain/index.sh

# if [ "$#" -ne 4 ]; then
#   echo "Usage: ./run_parachain.sh <parachain_git_url> <binary_name> <binary_json_chain_spec>"
#   exit 1
# fi

parachain_chain_spec=''

while getopts "g:b:z:p:" option; do
  case $option in
    g)
      git_url=$OPTARG
      ;;
    b)
      binary_name=$OPTARG
      ;;
    z)
      zombienet_config=$OPTARG
      ;;
    p)
      parachain_chain_spec=$OPTARG
      ;;
    \?) # Invalid option
      echo "Error: Invalid option"
      exit;;
    esac
  done
  
HOME_DIR=$HOME

cd $HOME_DIR
# install_linux_packages
# install_rust
# install_nvm
# install_nodejs18

# install_polkadot

# install_parachain
# build_parachain
# link_parachain

install_and_build_zombienet

get_zombienet_config
update_zombienet_config

get_parachain_chain_spec
run_zombienet_parachain