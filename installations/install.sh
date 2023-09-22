#!/bin/bash

install_rust() {
  # Install Rust using rustup
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
}

install_linux_packages() {
  # Install required dependencies
  sudo apt-get install -y git clang curl libssl-dev llvm libudev-dev protobuf-compiler cmake make libclang-dev build-essential jq
}

install_nvm() {
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
source ~/.bashrc
}

install_nodejs18() {
  nvm install v18.16.0
  nvm use v18.16.0
  npm install --global yarn
}

repo_setup() {
  cd $work_dir
  if [ -d $work_dir/$repo_dir ] 
  then
    echo "Directory $work_dir/$repo_dir exists." 
  else
    # Clone the specified Git repository
    sudo git clone $repo --depth 1
    # Get the name of the repository directory
    # Change ownership of the repository directory to the current user
    sudo chown -R $USER:$USER $work_dir/$repo_dir
    # Configure Git to recursively clone submodules
    cd $work_dir/$repo_dir && git config --global submodule.recurse true
    cd ..
  fi
}

run_init() {
  if [ -d $work_dir/$repo_dir/$repo_dir/scripts ]
  then
    if [ -f $work_dir/$repo_dir/$repo_dir/scripts/init.sh ]
    then
      chmod u+x ./scripts/init.sh
      ./scripts/init.sh
    fi
  else
    echo "No ./init.sh file"
  fi
}

copy_bin() {
  cd $work_dir/$repo_dir
  if [[ -f $work_dir/$repo_dir/target/release/$binary_name ]] 
  then
    if ! [[ -f $bin_dir/$binary_name ]]
    then
      cp $work_dir/$repo_dir/target/release/$binary_name $bin_dir/$binary_name-bin 
      echo 'copied'
    fi
  elif [[ -f $work_dir/$repo_dir/target/production/$binary_name ]]
  then
    cp $work_dir/$repo_dir/target/production/$binary_name $bin_dir/$binary_name-bin 
    echo true
  else
    echo false
  fi
}


build_binary() {
  cd $repo_dir
  $parachain_cmd
}

install_polkadot() {
  cd $HOME
  wget https://github.com/paritytech/polkadot/releases/download/v1.0.0/polkadot
  sudo chmod 777 $HOME/polkadot
  sudo ln -s $HOME/polkadot /usr/local/bin
}

get_parachain_chain_spec() {
  curl https://raw.githubusercontent.com/sankar-boro/files/main/parachain/parachain_chain_spec.json -o $HOME/parachain_chain_spec.json
}