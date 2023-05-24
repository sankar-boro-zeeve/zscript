#!/bin/bash

run_binary() {
    DATA_DIR_NAME=${name}-data
    ZEEVE_DIR=$HOME/zeeve
    DATA_DIR=$ZEEVE_DIR/$DATA_DIR_NAME

    cd $ZEEVE_DIR
    mkdir -p $DATA_DIR_NAME

    chainkey=""

    if [ "$lspec" = "true" ];
    then
        chainkey="./$repo_dir/$specf"
    else
        chainkey=$pchain
    fi

    echo "--chain ${chainkey}"
    
    if [ $node == "relay&para"]
    then
        ./${bname}-bin \
        --port 30333 \
        --rpc-port 9933 \
        --ws-port 9944 \
        --execution wasm \
        --wasm-execution compiled \
        --pruning=archive \
        --base-path $DATA_DIR \
        --chain ${chainkey} \
        --name "${pchain}-full-node" \
        --unsafe-rpc-external \
        --unsafe-ws-external \
        --rpc-cors="all" \
        -- \
        --port 30334 \
        --rpc-port 9934 \
        --ws-port 9945 \
        --chain ${rchain} \
        --execution wasm \
        --name="${rchain}-full-node (Embedded Relay)"
    else
        ./${bname}-bin \
        --port 30333 \
        --rpc-port 9933 \
        --execution wasm \
        --wasm-execution compiled \
        --pruning=archive \
        --base-path $DATA_DIR \
        --chain ${chainkey} \
        --name "${pchain}-full-node" \
        --unsafe-rpc-external \
        --rpc-cors="all"
    fi
}


        # ./target/release/watr-node \
        # --port 30333 \
        # --rpc-port 9933 \
        # --ws-port 9944 \
        # --execution wasm \
        # --wasm-execution compiled \
        # --pruning=archive \
        # --tmp \
        # --chain ./chain-specs/mainnet-raw.json \
        # --name "watr-full-node" \
        # --unsafe-rpc-external \
        # --unsafe-ws-external \
        # --rpc-cors="all" \
        # -- \
        # --port 30334 \
        # --rpc-port 9934 \
        # --ws-port 9945 \
        # --chain polkadot \
        # --execution wasm \
        # --name="polkadot-full-node (Embedded Relay)"