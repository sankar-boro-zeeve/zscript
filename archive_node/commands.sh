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
    if [ -d $HOME/zeeve/$repo_dir/scripts ]
    then
        if [ -f $HOME/zeeve/$repo_dir/scripts/init.sh ]
        then
            ./scripts/init.sh
        fi
    else
        echo "No ./init.sh file"
    fi

    cargo build --release
}