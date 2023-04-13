#!/bin/bash

source help.sh
source get_args.sh
source install.sh

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


# install_rust
# install_linux_packages
repo_setup
build_binary ${name}
# ./main.sh -g https://github.com/PureStake/moonbeam -n moonbeam -r polkadot -p moonbeam -u sankar

DATA_DIR=${name}-data
mkdir ${DATA_DIR}

run_binary() {
./target/release/${name} \
--port 30333 \
--rpc-port 9933 \
--ws-port 9944 \
--execution wasm \
--wasm-execution compiled \
--pruning=archive \
--base-path ./${DATA_DIR} \
--chain ${para_chain} \
--name "${name}-full-node" \
--unsafe-rpc-external \
--unsafe-ws-external \
--rpc-cors="all" \
-- \
--port 30334 \
--rpc-port 9934 \
--ws-port 9945 \
--chain ${relay_chain}
--execution wasm \
--name="${name}-full-node (Embedded Relay)"
}

# run_binary

# --state-pruning=archive \
# --trie-cache-size 0 \
# --db-cache <ram-in-mb> \