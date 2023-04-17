#!/bin/bash

source help.sh
source get_args.sh
source install.sh
source run.sh

if [[ $@ == *"-h"* ]]
  then
    Help
    exit 1
fi

run_args "${@}"

# Check if a Git repository URL has been provided
if [ "$#" -ne 10 ]
then
	echo "Usage: ./binary.sh -g <github-url> -n <name> -r <relay_chain> -p <para_chain> -u ubuntu"
	exit 1
fi

install_rust
install_linux_packages
repo_setup
build_binary ${name}
run_binary

# ./main.sh -g https://github.com/PureStake/moonbeam -n moonbeam -r polkadot -p moonbeam -u sankar


# --state-pruning=archive \
# --trie-cache-size 0 \
# --db-cache <ram-in-mb> \