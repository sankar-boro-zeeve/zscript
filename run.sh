#!/bin/bash

run_binary() {
    
    if [[ $archive_type == "relay&para" ]]
    then
        ${binary_name}-bin \
        --port 30333 \
        --rpc-port 9933 \
        --execution wasm \
        --wasm-execution compiled \
        --pruning=archive \
        --base-path $data_dir \
        --chain ${chain} \
        --name "${parachain}-archive-node" \
        --unsafe-rpc-external \
        --rpc-cors="all" \
        -- \
        --port 30334 \
        --rpc-port 9934 \
        --chain polkadot \
        --execution wasm \
        --name="${polkadot}-full-node (Embedded Relay)"
    else
        ${binary_name}-bin \
        --port 30333 \
        --rpc-port 9933 \
        --execution wasm \
        --wasm-execution compiled \
        --pruning=archive \
        --base-path $data_dir \
        --chain ${chain} \
        --name "${parachain}-archive-node" \
        --unsafe-rpc-external \
        --rpc-cors="all"
    fi
}