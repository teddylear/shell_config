package main

import (
    "dagger.io/dagger"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    // TODO: Maybe add exclude here
    client: filesystem: "./": read: contents: dagger.#FS

    actions: fmt: docker.#Build & {
        steps: [
            docker.#Dockerfile & {
                source: client.filesystem."./".read.contents
                dockerfile: contents: #"""
                    FROM rust:latest
                    RUN mkdir -p /tmp/
                    WORKDIR /tmp
                    RUN cargo install stylua
                    CMD stylua nvim/.config/nvim/
                    """#
            },
            docker.#Run & {
                mounts: {
                    "./": {
                        dest:  "./"
                        type: "fs"
                        contents: client.filesystem."./".read.contents
                        source: "./"
                        ro: false
                    }
                }
            },
        ]
    }
}
