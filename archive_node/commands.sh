#!/bin/bash

crust_build() {
    echo "crust build"
    ./scripts/init.sh
    cargo build --release
}

acala_build() {
    echo "cargo build --release --features with-$name-runtime"
    git submodule update --init --recursive
    cargo build --release --features with-$name-runtime
    cp ./target/release/acala ../$name-bin
    cd ..
}

karura_build() {
    echo "Karura build"
    acala_build
}

mandala_build() {
    echo "mandala build"
    acala_build
}

default_build() {
    echo "default build"
    cargo build --release
}