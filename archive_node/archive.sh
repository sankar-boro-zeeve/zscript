#!/bin/bash

source archive_node_help.sh
source get_args.sh

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

# ./binary.sh -g https://github.com/PureStake/moonbeam -n moonbeam -r polkadot -p moonbeam -u sankar

repo_dir=$(echo $git_link | awk -F/ '{print $NF}' | sed 's/.git$//')

echo "repo_dir: ${repo_dir}"
echo "name: ${name}"


cd $repo_dir
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

run_binary

# --state-pruning=archive \
# --trie-cache-size 0 \
# --db-cache <ram-in-mb> \