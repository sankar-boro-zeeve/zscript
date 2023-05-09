#!/bin/bash

source help.sh
source get_args.sh
source install.sh
source run.sh
source commands.sh

if [[ $@ == *"-h"* ]]
  then
    Help
    exit 1
fi

run_args "${@}"

# Check if a Git repository URL has been provided
if [ "$#" -ne 1 ]
then
	echo "Usage: ./main.sh <name>. Eg: ./main.sh moonbeam"
	exit 1
fi

# install_rust
# install_linux_packages
repo_setup
build_binary ${name}
run_binary

# ./main.sh -g https://github.com/PureStake/moonbeam -n moonbeam -r polkadot -p moonbeam -u sankar


# --state-pruning=archive \
# --trie-cache-size 0 \
# --db-cache <ram-in-mb> \