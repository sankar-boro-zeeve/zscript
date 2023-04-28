#!/bin/bash

crust_build() {
    ./scripts/init.sh
    cargo build --release
}

default_build() {
    cargo build --release
}