#!/bin/bash

BASE_PATH=${1}

wget https://github.com/PureStake/moonbeam/releases/download/v0.29.0/moonbeam
mv moonbeam "${BASE_PATH}/moonbeam-data/"

${BASE_PATH}/moonbeam-data/moonbeam \
--port 30333 \
--rpc-port 9933 \
--ws-port 9944 \
--execution wasm \
--wasm-execution compiled \
--state-pruning=archive \
--trie-cache-size 0 \
--db-cache 6000 \
--base-path ${BASE_PATH}/moonbeam-data \
--chain moonbeam \
--name "moonbeam-para" \
--unsafe-rpc-external \
--unsafe-ws-external \
--rpc-cors all \
-- \
--port 30334 \
--rpc-port 9934 \
--ws-port 9945 \
--execution wasm \
--name "moonbeam-relay" &> ${BASE_PATH}/moonbeam-data/moonbeam.log