#!/bin/bash

# git_link=""
# name=""
# relay_chain=""
# para_chain=""
# USER=""

# run_args() {
#   while getopts "hg:n:p:r:u:" option; do
#     case $option in
#         h) # display Help
#           Help
#           exit;;
#         g)
#           git_link=$OPTARG
#           ;;
#         n)
#           name=$OPTARG
#           ;;
#         p)
#           para_chain=$OPTARG
#           ;;
#         r)
#           relay_chain=$OPTARG
#           ;;
#         u)
#           USER=$OPTARG
#           ;;
#         \?) # Invalid option
#           echo "Error: Invalid option"
#           exit;;
#     esac
#   done

# }

run_args() {
  NAME=$1
  name=""
  gitlink=""
  repo_dir=""
  bname=""
  rchain=""
  pchain=""

  env_file=`cat list.txt`
  line=$(echo "$env_file" | grep ${NAME})

  IFS=' '
  read -ra ADDR <<< "$line"

  name=${ADDR[0]}
  rchain=${ADDR[1]}
  gitlink=${ADDR[2]}
  repo_dir=${ADDR[3]}
  bname=${ADDR[4]}
  pchain=${ADDR[5]}
  lspec=${ADDR[6]}
  specf=${ADDR[7]}
}
