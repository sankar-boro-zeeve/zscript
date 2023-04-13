#!/bin/bash

git_link=""
name=""
relay_chain=""
para_chain=""
USER=""

run_args() {
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

}