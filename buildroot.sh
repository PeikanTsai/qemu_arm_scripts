#!/bin/bash

REPO_ROOT=`pwd`
OUT_DIR=$REPO_ROOT/out

git clone https://git.buildroot.net/buildroot -b master --depth=1
make -C buildroot qemu_aarch64_virt_defconfig
make -C buildroot
#BR2_DEFCONFIG=

# build kernel
git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git --depth=1 -b master
make -C linux LLVM=1 ARCH=arm64 O=$OUT_DIR/linux defconfig
make -C linux LLVM=1 ARCH=arm64 O=$OUT_DIR/linux Image -j4

# collect image
rsync -av buildroot/output/images $OUT_DIR/
rsync -av $OUT_DIR/linux/arch/arm64/boot/Image $OUT_DIR/images

# run
$OUT_DIR/images/start-qemu.sh
