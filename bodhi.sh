#!/bin/bash

echo "installing @microsoft/rush..."
sudo npm install -g @microsoft/rush

git clone GitHub - AcalaNetwork/bodhi.js 
cd bodhi.js && git submodule update --init --recursive
rush update && rush build -t @acala-network/eth-rpc-adapter
npx @acala-network/eth-rpc-adapter -l -e ws://localhost:9944