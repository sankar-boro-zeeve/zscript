#!/bin/bash

run_zombienet() {
  cd $HOME/zn
  node ./dist/cli.js spawn --provider native $1
}