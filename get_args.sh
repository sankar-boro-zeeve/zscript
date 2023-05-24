#!/bin/bash

node="relay&para"

run_argss() {
  while getopts "n:" option; do
    case $option in
        n)
          node=$OPTARG
          ;;
        \?) # Invalid option
          echo "Error: Invalid option"
          exit;;
    esac
  done

}

run_args() {
  NAME=$1
  name=""
  gitlink=""
  repo_dir=""
  bname=""
  rchain="polkadot"
  pchain=""

  env_file=`cat list.txt`
  line=$(echo "$env_file" | grep ${NAME})

  IFS=' '
  read -ra ADDR <<< "$line"

  name=${ADDR[0]}
  gitlink=${ADDR[1]}
  repo_dir=${ADDR[2]}
  bname=${ADDR[3]}
  pchain=${ADDR[4]}
  lspec=${ADDR[5]}
  specf=${ADDR[6]}
}
