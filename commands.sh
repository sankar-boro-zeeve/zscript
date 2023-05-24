#!/bin/bash

acala_build() {
    git submodule update --init --recursive
    cargo build --locked --features with-all-runtime
}

astar_build() {
    git submodule update --init --recursive
    cargo build --release
}

bifrost_build() {
    mkdir -p "target/release/res"
	cp -r node/service/res/genesis_config target/release/res
	cargo build -p node-cli --locked --features "with-all-runtime" --release
}

bitgreen_build() {
    cargo build --release -p bitgreen-parachain
}

bridgehub_build() {
    default_build
}

crust_build() {
    default_build
}

frequency_build() {
    cargo build --locked --features frequency --release
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

nodle_build() {
    cargo build --release -p nodle-parachain
}

oak_build() {
    cargo build --locked --release --features turing-node,oak-node
}

centrifuge_build() {
    chmod +x ./scripts/install_toolchain.sh
    ./scripts/install_toolchain.sh
    cargo build --release --features=fast-runtime
}