#!/bin/bash

source install.sh
source git_packages.sh

install_rust
install_linux_packages
install_nvm
install_nodejs18
install_zombienet


run_parachain