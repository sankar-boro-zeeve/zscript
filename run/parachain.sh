#!/bin/bash

run_zombienet() {
  cd $HOME
  curl https://raw.githubusercontent.com/sankar-boro/files/main/parachain/parachain-config.json -o $HOME/raw.json
  data=$(jq '.parachains[0].collators[0].command = "genesis-node"' $HOME/raw.json | jq '.' > $HOME/parachain-config.json)
  node $HOME/zn/dist/cli.js spawn --provider native $HOME/parachain-config.json
}