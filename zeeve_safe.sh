#!/bin/bash

# Check if the -b flag has been passed
# build=false
# if [[ $* == *-b* ]]
# then
#   build=true
# fi

# Install Rust using rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

# Install required dependencies
sudo apt-get install -y git clang curl libssl-dev llvm libudev-dev protobuf-compiler cmake make libclang-dev build-essential

# Clone the specified Git repository
sudo git clone $git_link --depth 1

# Get the name of the repository directory
repo_dir=$(echo $git_link | awk -F/ '{print $NF}' | sed 's/.git$//')

# Change ownership of the repository directory to the current user
sudo chown -R $USER:$USER $repo_dir

# Configure Git to recursively clone submodules
cd $repo_dir && git config --global submodule.recurse true

acala_chain() {
	make init && cargo build --release --features with-$1-runtime
}

generic_chain() {
  cargo build --release
}

if [ $build_name == "acala" ]
then
  acala_chain acala
elif [ $build_name == "mandala" ]
then
  acala_chain mandala
elif [ $build_name == "karura" ]
then
  acala_chain karura
elif [ $build_name == "generic" ]
then
  generic_chain
else
	echo "nothing found."
fi