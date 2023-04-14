#!/bin/bash

repo_dir=""

install_rust() {
# Install Rust using rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
}

install_linux_packages() {
# Install required dependencies
sudo apt-get install -y git clang curl libssl-dev llvm libudev-dev protobuf-compiler cmake make libclang-dev build-essential
}

repo_setup() {
cd $HOME
# Clone the specified Git repository
sudo git clone $git_link --depth 1
# Get the name of the repository directory
repo_dir=$(echo $git_link | awk -F/ '{print $NF}' | sed 's/.git$//')
# Change ownership of the repository directory to the current user
sudo chown -R $USER:$USER $repo_dir
# Configure Git to recursively clone submodules
cd $HOME/$repo_dir && git config --global submodule.recurse true
}

acala_chain() {
	git submodule update --init --recursive
  cargo build --release --features with-$1-runtime
  cp ./target/release/acala ~/$1
}

generic_chain() {
  cargo build --release
  cp ./target/release/$1
}

build_binary() {
if [ $1 == "acala" ]
then
  acala_chain acala
elif [ $1 == "mandala" ]
then
  acala_chain mandala
elif [ $1 == "karura" ]
then
  acala_chain karura
elif [ $1 == "generic" ]
then
  generic_chain $1
else
	generic_chain $1
fi
}