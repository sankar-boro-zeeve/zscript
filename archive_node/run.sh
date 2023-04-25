#!/bin/bash

run_binary() {
    DATA_DIR_NAME=${name}-data
    ZEEVE_DIR=$HOME/zeeve
    DATA_DIR=$ZEEVE_DIR/$DATA_DIR_NAME

    cd $ZEEVE_DIR
    mkdir -p $DATA_DIR_NAME

    ./${bname}-bin \
    --port 30333 \
    --rpc-port 9933 \
    --ws-port 9944 \
    --execution wasm \
    --wasm-execution compiled \
    --pruning=archive \
    --base-path $DATA_DIR \
    --chain ${pchain} \
    --name "${name}-full-node" \
    --unsafe-rpc-external \
    --unsafe-ws-external \
    --rpc-cors="all" \
    -- \
    --port 30334 \
    --rpc-port 9934 \
    --ws-port 9945 \
    --chain ${rchain}
    --execution wasm \
    --name="${name}-full-node (Embedded Relay)"
}