#!/bin/bash

install_zombienet() {
  git clone https://github.com/paritytech/zombienet.git
  cd zombienet
  yarn install
}