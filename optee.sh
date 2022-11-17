#!/bin/bash
# See https://optee.readthedocs.io/en/latest/building/prerequisites.html for required packages

repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
repo sync --no-clone-bundle -c
cd build
make toolchains
make run
