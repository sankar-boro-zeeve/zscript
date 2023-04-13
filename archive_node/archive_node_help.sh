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