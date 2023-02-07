#!/bin/bash

BASE_PATH=${1}

source ${BASE_PATH}/zscript/packages.sh

${BASE_PATH}/acala-data/acala \
--base-path ${BASE_PATH}/acala-data \
--chain=acala \
--name "acala-para" \
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
--name "acala-relay &> ${BASE_PATH}/acala-data/acala.log"

source ${BASE_PATH}/zscript/bodhi.sh ${BASE_PATH}