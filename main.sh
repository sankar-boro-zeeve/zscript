#!/bin/bash

source help.sh
source get_args.sh
source installations/install.sh
source run.sh

if [[ $@ == *"-h"* ]]
then
  Help
  exit 0
fi

if [[ $@ == *"-l"* ]]
  then
  List
  exit 0
fi

set_envs "${@}"
HOME_DIR=$HOME
work_dir=$HOME_DIR/zeeve
archive_type="relay&para"
data_dir=$HOME_DIR/.data
bin_dir=$HOME/bin

echo $HOME_DIR
echo $work_dir
echo $archive_type
echo $data_dir
echo $bin_dir
# run_argss "${@}"

# Check if a Git repository URL has been provided
# if [ "$#" -lt 1 ]
# then
# 	echo "Usage: ./main.sh <name>. Eg: ./main.sh moonbeam"
# 	exit 1
# fi

# install_rust
# install_linux_packages
# repo_setup
# build_binary
copy_bin
run_binary