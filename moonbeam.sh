#!/bin/bash

CHAIN=${1}
PWD=$(pwd)
# cd "${CHAIN}-data"
echo ${CHAIN} ${PWD}
# wget https://github.com/PureStake/moonbeam/releases/download/v0.29.0/moonbeam
# cd ..
echo "Running moonbeam... ${CHAIN}"

# ${cwd}/${chain}-data/${chain} \
moonbeam \
--port 30333 \
--rpc-port 9933 \
--ws-port 9944 \
--execution wasm \
--wasm-execution compiled \
--state-pruning=archive \
--trie-cache-size 0 \
--db-cache 6000 \
--base-path ${PWD}/${CHAIN}-data \
--chain ${CHAIN} \
--name "${CHAIN}-full-node" \
--unsafe-rpc-external \
--unsafe-ws-external \
--rpc-cors all \
-- \
--port 30334 \
--rpc-port 9934 \
--ws-port 9945 \
--execution wasm \
--name "${chain}-full-node (Embedded Relay)"