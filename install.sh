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

run_init() {
  if [ -d $HOME/zeeve/$repo_dir/scripts ]
  then
    if [ -f $HOME/zeeve/$repo_dir/scripts/init.sh ]
    then
      chmod u+x ./scripts/init.sh
      ./scripts/init.sh
    fi
  else
    echo "No ./init.sh file"
  fi
}

copy_bin() {
  if [ -f $HOME/zeeve/$repo_dir/target/release/$bname ] 
  then
    cp ./target/release/$bname ../$bname-bin 
    echo true
  elif [ -f $HOME/zeeve/$repo_dir/target/production/$bname ]
  then
    cp ./target/production/$bname ../$bname-bin 
    echo true
  else
    echo false
  fi
}


build_binary() {
  build_command="${name}_build"
  cd $repo_dir

  run_init
  local res=$(copy_bin)
  
  if [ $res == true ]
  then
    cd ..
  else
    type $build_command &>/dev/null && $build_command || default_build
    copy_bin
    cd ..
  fi
}
