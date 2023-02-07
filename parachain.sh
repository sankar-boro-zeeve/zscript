#!/bin/bash

ARGS=$#
BASE_PATH=$(pwd)

function init() {
    if [[ ${ARGS} -ne 2 ]]
    then
        echo "Usage: ./parachain.sh -c moonbeam";
        exit 1;
    fi
}

init

while getopts c:n: option
do 
    case "${option}"
        in
        c)chain=${OPTARG};;
        n)name=${OPTARG};;
    esac
done

CHAIN_DIR="${chain}-data"
rm -rf $CHAIN_DIR
mkdir $CHAIN_DIR;
chmod 777 $CHAIN_DIR

source $(dirname "$0")/${chain}.sh ${BASE_PATH}


