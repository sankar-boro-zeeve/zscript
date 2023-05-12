#!/bin/bash

crust_build() {
    default_build
}

acala_build() {
    echo "cargo build --release --features with-$name-runtime"
    git submodule update --init --recursive
    cargo build --release --features with-$name-runtime
}

karura_build() {
    echo "Karura build"
    acala_build
}

mandala_build() {
    echo "mandala build"
    acala_build
}

manta_build() {
    cargo b --profile production
}

default_build() {
    cargo build --release
}

unique_build() {
    cargo build --features=unique-runtime --release
}

bifrost_build() {
    mkdir -p "target/release/res"
	cp -r node/service/res/genesis_config target/release/res
	cargo build -p node-cli --locked --features "with-all-runtime" --release
}