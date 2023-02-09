#!/bin/bash

BASE_PATH=${1}

source ${BASE_PATH}/zscript/packages.sh

echo "cloning acala repo..."

git clone https://github.com/AcalaNetwork/Acala.git
mv Acala acala
sudo chmod 777 acala
cd acala && sudo git config --global submodule.recurse true
sudo git config --global --add safe.directory /home/ubuntu/zeeve/acala
sudo git submodule update --init --recursive && cargo build --release --features with-acala-runtime
cd ..
cp acala/target/production/acala ./acala-data/

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