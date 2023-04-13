#!/bin/bash

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "HELP"
   echo
   echo "Usage: ./binary.sh -g <github-url> -b <binary-name> -r <relay_chain> -p <para_chain> -u ubuntu"
   echo "options:"
   echo "g     Github repository link. Eg: https://github.com/moonbeam/moonbeam"
   echo "h     Print this Help."
   echo "n     Name. Eg: moonbeam, acala, karura, etc. Use 'generic' for most common cases."
   echo "p     Para chain name. Eg: acala, phala, moonbeam, etc."
   echo "r     Relay chain name. Eg: polkadot, kusama, rococo, etc."
   echo "u     Username. Eg: ubuntu"
   echo
}

if [[ $@ == *"-h"* ]]
  then
    Help
    exit 1
fi

# Check if a Git repository URL has been provided
if [ "$#" -ne 10 ]
then
	echo "Usage: ./binary.sh -g <github-url> -n <name> -r <relay_chain> -p <para_chain> -u ubuntu"
	exit 1
fi

git_link=""
name=""
relay_chain=""
para_chain=""
USER=""

while getopts "hg:n:p:r:u:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      g)
        git_link=$OPTARG
        ;;
      n)
        name=$OPTARG
        ;;
      p)
        para_chain=$OPTARG
        ;;
      r)
        relay_chain=$OPTARG
        ;;
      u)
        USER=$OPTARG
        ;;
      \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

repo_dir=$(echo $git_link | awk -F/ '{print $NF}' | sed 's/.git$//')

echo "repo_dir: ${repo_dir}"
echo "name: ${name}"


cd $repo_dir
DATA_DIR=${name}-data
mkdir ${DATA_DIR}

run_binary() {
./target/release/${name} \
--port 30333 \
--rpc-port 9933 \
--ws-port 9944 \
--execution wasm \
--wasm-execution compiled \
--pruning=archive \
--base-path ./${DATA_DIR} \
--chain ${para_chain} \
--name "${name}-full-node" \
--unsafe-rpc-external \
--unsafe-ws-external \
--rpc-cors="all" \
-- \
--port 30334 \
--rpc-port 9934 \
--ws-port 9945 \
--chain ${relay_chain}
--execution wasm \
--name="${name}-full-node (Embedded Relay)"
}

run_binary

# --state-pruning=archive \
# --trie-cache-size 0 \
# --db-cache <ram-in-mb> \