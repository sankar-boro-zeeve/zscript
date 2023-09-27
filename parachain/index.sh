#!/bin/bash

# git_url
# binary_name
# parachain_chain_spec

install_polkadot() {
  echo "Installing polkadot..."
  cd $HOME_DIR
  if ! [ -f $HOME_DIR/polkadot ]
  then
    wget https://github.com/paritytech/polkadot/releases/download/v1.0.0/polkadot
    sudo chmod 777 $HOME_DIR/polkadot
    sudo ln -s $HOME_DIR/polkadot /usr/local/bin
  fi
}

install_parachain() {
  echo "Git clone: $git_url"
  repo_dir=$(echo "$git_url" | awk -F'/' '{print $NF}')

  if ! [ -d "$HOME/$repo_dir" ]
  then
    git clone $git_url
  fi
}

build_parachain() {
  echo "Building parachain: $repo_dir"
  cd $HOME_DIR/$repo_dir
  cargo build --release
  cd $HOME_DIR
}

link_parachain() {
  echo "Linking parachain: sudo ln -s $HOME_DIR/parachan-bin /usr/local/bin..."
  cp $HOME_DIR/$repo_dir/target/release/$binary_name $HOME_DIR/parachan-bin
  sudo chmod 777 $HOME_DIR/parachain-bin
  sudo ln -s $HOME_DIR/parachan-bin /usr/local/bin
  cd $HOME_DIR
}

get_parachain_chain_spec() {
  echo "Getting parachain chain spec"
    # https://raw.githubusercontent.com/sankar-boro/files/main/parachain/parachain_chain_spec.json
  curl $parachain_chain_spec -o $HOME_DIR/parachain_chain_spec.json
}

install_and_build_zombienet() {
  echo "Installing and building zombienet...."
  cd $HOME_DIR

  if ! [ -d "$HOME_DIR/zombienet" ]
  then
    git clone https://github.com/paritytech/zombienet.git
  fi

  cd zombienet/javascript
  yarn install
  yarn build
  mkdir $HOME_DIR/zn
  cp -r ./packages/cli/dist $HOME_DIR/zn
  cp ./packages/cli/package.json $HOME_DIR/zn
  cd $HOME_DIR/zn
  yarn install
  cd $HOME_DIR
}

get_zombienet_config() {
  echo "Get zombienet config..."
  curl https://raw.githubusercontent.com/sankar-boro/files/main/parachain/zombienet-config.json -o $HOME_DIR/zombienet-config-raw.json
}

update_zombienet_config() {
  echo "Update zombienet config..."
  data=$(jq '.parachains[0].collators[0].command = "parachain-bin"' $HOME_DIR/zombienet-config-raw.json | jq '.' > $HOME_DIR/zombienet-config.json)
}

run_zombienet_parachain() {
  echo "Run zombienet parachain..."
  cd $HOME_DIR/zn
  node ./dist/cli.js spawn --provider native $HOME_DIR/zombienet-config.json
}