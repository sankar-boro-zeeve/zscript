#!/bin/bash

ARGS=$#

if [[ ${ARGS} -ne 2 ]]
then
    echo "Usage: ./parachain.sh -c moonbeam";
    exit 1;
fi

while getopts c:n: option
do 
    case "${option}"
        in
        c)chain=${OPTARG};;
        n)name=${OPTARG};;
    esac
done

CUR_DIR=$(pwd)

NEW_DIR="${chain}-data"
rm -rf $NEW_DIR;
mkdir $NEW_DIR;

source $(dirname "$0")/${chain}.sh
hello
# if [[ ${chain} -eq "moonbeam" ]]
# then
#     echo "Username is ${chain}";
#     ${hello}
#     exit 0;
# fi


