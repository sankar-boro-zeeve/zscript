#!/bin/bash

run_zombienet() {
  data=$(jq '.parachains[0].collators[0].command = "polkadot"' ./run/test.json | jq '.' > $HOME/para_test.json)
  node $HOME/zn/dist/cli.js spawn --provider native $HOME/para_test.json
}