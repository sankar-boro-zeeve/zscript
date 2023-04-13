#!/bin/bash

run_binary() {
DATA_DIR=${name}-data
mkdir ${DATA_DIR}
# echo $name
# echo $para_chain
# echo $relay_chain
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