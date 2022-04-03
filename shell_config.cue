package main

import (
    "dagger.io/dagger"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    client: filesystem: "./": read: contents: dagger.#FS

    actions: {
        fmtCheck: {
            build: docker.#Dockerfile & {
                source: client.filesystem."./".read.contents
                dockerfile: contents: #"""
                    FROM rust:latest
                    RUN mkdir -p /tmp/
                    WORKDIR /tmp
                    RUN cargo install stylua
                    CMD stylua --check nvim/.config/nvim/.
                    """#
            }
            run: docker.#Run & {
                input: build.output
                mounts: {
                    "./": {
                        dest:  "/tmp"
                        type: "fs"
                        contents: client.filesystem."./".read.contents
                        ro: false
                    }
                }
                command: {
                    name: "stylua"
                    args: ["--check", "nvim/.config/nvim/."]
                }
            }
        }
    }
}
