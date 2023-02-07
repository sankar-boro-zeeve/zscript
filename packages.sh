#!/bin/bash

echo "installing linux and rust dependencies..."
sudo apt remove rush
sudo apt install build-essential git clang libclang-dev pkg-config libssl-dev cmake
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "installing node.js..."
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
