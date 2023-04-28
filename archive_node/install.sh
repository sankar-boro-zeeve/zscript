#!/bin/bash

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
  cd $HOME/zeeve
  # repo_dir=$(echo $git_link | awk -F/ '{print $NF}' | sed 's/.git$//')
  if [ -d $HOME/zeeve/$repo_dir ] 
  then
    echo "Directory $HOME/zeeve/$repo_dir exists." 
  else
    # Clone the specified Git repository
    sudo git clone $gitlink --depth 1
    # Get the name of the repository directory
    # Change ownership of the repository directory to the current user
    sudo chown -R $USER:$USER $repo_dir
    # Configure Git to recursively clone submodules
    cd $repo_dir && git config --global submodule.recurse true
    cd ..
  fi
}

acala_chain() {
  cd $repo_dir
  if [ -f $HOME/zeeve/$repo_dir/target/release/$bname ] 
  then
    cp ./target/release/$bname ../$bname-bin 
  else
    git submodule update --init --recursive
    cargo build --release --features with-$bname-runtime
    cp ./target/release/acala ../$bname-bin
    cd ..
  fi
}

generic_chain() {
  echo "lksjdfs"
  cd $repo_dir
  if [ -f $HOME/zeeve/$repo_dir/target/release/$bname ] 
  then
    echo "came here 1"
    cp ./target/release/$bname ../$bname-bin 
    cd ..
  else
    echo "came here 2"
    echo $build_command
    $build_command
    cd ..
  fi
}

build_binary() {
  if [ $name == "acala" ]
  then
    acala_chain
  elif [ $name == "mandala" ]
  then
    acala_chain
  elif [ $name == "karura" ]
  then
    acala_chain
  elif [ $name == "generic" ]
  then
    generic_chain
  else
    generic_chain
  fi
}