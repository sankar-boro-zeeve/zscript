#!/bin/bash

install_zombienet() {
  git clone https://github.com/paritytech/zombienet.git
  cd zombienet/javascript
  yarn install
  yarn build
  mkdir $HOME/zn
  cp -r ./packages/cli/dist $HOME/zn
  cp package.json $HOME/zn
  cd $HOME/zn
  yarn install
}