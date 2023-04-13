#!/bin/bash

get_params(){

    PARAMS=""
    while (( "$#" )); do
    case "$1" in
           
        ## RESET - boolean
        -r|--reset)
        RESET=true
        shift
        ;;
        
        ## AGE
        -a|--age)
        if [ -n "${2}" ] && [ ${2:0:1} != "-" ]; then
            AGE=$2
            shift 2
        else
            echo "Error: Argument for $1 is missing" >&2
            exit 1
        fi
        ;;

        ## NAME
        -n|--name)
        if [ -n "${2}" ] && [ ${2:0:1} != "-" ]; then
            NAME=${2}
            shift 2
        else
            echo -e "Error: Argument for $1 is missing" >&2
            exit 1
        fi
        ;;

        -*|--*=) # unsupported flags
        echo -e "Error: Unsupported flag $1" >&2
        print_usage
        exit 1
        ;;

        *) # preserve positional arguments
        PARAMS="$PARAMS $1"
        shift
        ;;
    esac
    done
    # set positional arguments in their proper place
    eval set -- "${PARAMS}"

    # sanity checks
    [[ -z "${AGE}" && -z "${NAME}" ]] && { echo "You must provide either a Name or Age '--name joe or --age 25'. exiting.."; exit 1; }
}