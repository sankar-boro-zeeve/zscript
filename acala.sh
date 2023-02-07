#!/bin/bash

CHAIN=${1}
BASE_PATH=${2}

source $(dirname "$0")/packages.sh

${cwd}/${chain}-data/${chain} \
acala \
--base-path ${PWD}/${CHAIN}-data \
--chain=acala \
--name "${CHAIN}-para" \
--pruning=archive \
--ws-external \
--rpc-external \
--rpc-cors=all \
--ws-port=9944 \
--rpc-port=9933 \
--ws-max-connections=2000 \
--execution=wasm \
-- \
--chain=kusama \
--name "${chain}-relay &> ${cwd}/${chain}-data/${chain}.log"

source $(dirname "$0")/bodhi.sh