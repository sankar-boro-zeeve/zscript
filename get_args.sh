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

set_envs() {
  NAME=$1
  PARACHAIN=$( jq -r .$NAME ./archive_nodes.json; )
  echo $PARACHAIN
  para_id=$(echo $PARACHAIN | jq -r .para_id)
  chain_type=$(echo $PARACHAIN | jq -r .chain_type)
  parachain=$(echo $PARACHAIN | jq -r .parachain)
  repo=$(echo $PARACHAIN | jq -r .repo)
  repo_dir=$(echo $PARACHAIN | jq -r .repo_dir)
  parachain_cmd=$(echo $PARACHAIN | jq -r .cmd)
  spec_file=$(echo $PARACHAIN | jq -r .spec_file)
  binary_name=$(echo $PARACHAIN | jq -r .binary_name)
  chain=$(echo $PARACHAIN | jq -r .chain)

  echo "$repo_dir"
}
