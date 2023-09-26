#!/bin/bash

# git_url
# binary_name
# parachain_chain_spec

install_polkadot() {
  cd $HOME
  wget https://github.com/paritytech/polkadot/releases/download/v1.0.0/polkadot
  sudo chmod 777 $HOME/polkadot
  sudo ln -s $HOME/polkadot /usr/local/bin
}

install_parachain() {
  git clone $git_url
  repo_dir=$(echo "$git_url" | awk -F'/' '{print $NF}')
}

build_parachain() {
  cd $repo_dir
  cargo build --release
  cd $HOME
}

link_parachain() {
  cd $repo_dir
  cp ./target/release/$binary_name $HOME/parachan-bin
  sudo ln -s $HOME/parachan-bin /usr/local/bin
  cd $HOME
}

get_parachain_chain_spec() {
    # https://raw.githubusercontent.com/sankar-boro/files/main/parachain/parachain_chain_spec.json
  curl $parachain_chain_spec -o $HOME/parachain_chain_spec.json
}

install_and_build_zombienet() {
  cd $HOME
  git clone https://github.com/paritytech/zombienet.git
  cd zombienet/javascript
  yarn install
  yarn build
  mkdir $HOME/zn
  cp -r ./packages/cli/dist $HOME/zn
  cp ./packages/cli/package.json $HOME/zn
  cd $HOME/zn
  yarn install
  cd $HOME
}

get_zombienet_config() {
  curl https://raw.githubusercontent.com/sankar-boro/files/main/parachain/zombienet-config.json -o $HOME/zombienet-config-raw.json
}

update_zombienet_config() {
  data=$(jq '.parachains[0].collators[0].command = "parachain-bin"' $HOME/zombienet-config-raw.json | jq '.' > $HOME/zombienet-config.json)
}

run_zombienet_parachain() {
  cd $HOME/zn
  node ./dist/cli.js spawn --provider native $HOME/zombienet-config.json
}