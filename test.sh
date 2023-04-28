#!/bin/bash

source commands.sh

run_args() {
    name="crust"
    build_command=${name}_build
    echo ${!build_command}
}

run_args