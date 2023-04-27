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
  build_command="default"

  env_file=`cat list.txt`
  commands_file=`cat commands.txt`  
  line=$(echo "$env_file" | grep ${NAME})
  line2=$(echo "$commands_file" | grep ${NAME})

  IFS=' '
  read -ra ADDR <<< "$line"
  read -ra ADDR2 <<< "$line2"

  name=${ADDR[0]}
  gitlink=${ADDR[1]}
  repo_dir=${ADDR[2]}
  bname=${ADDR[3]}
  rchain=${ADDR[4]}
  pchain=${ADDR[5]}
  lspec=${ADDR[6]}
  specf=${ADDR[7]}
  build_command="${ADDR2[1]} ${ADDR2[2]}"
}
