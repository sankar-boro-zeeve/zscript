#!/bin/bash

run_parachain() {
  cd $HOME_DIR
  curl https://raw.githubusercontent.com/sankar-boro/files/main/parachain/parachain-config.json -o $HOME_DIR/raw.json
  data=$(jq '.parachains[0].collators[0].command = "genesis-node"' $HOME_DIR/raw.json | jq '.' > $HOME_DIR/parachain-config.json)
  node $HOME_DIR/zn/dist/cli.js spawn --provider native $HOME_DIR/parachain-config.json
}