#!/bin/bash
set -e

ARCHDIR=$(dirname $0)
KERNELDIR="$ARCHDIR/../../kernel"
BUILDDIR="$ARCHDIR/build"

mkdir -p $BUILDDIR

nasm -f elf64 $ARCHDIR/boot.s -o $BUILDDIR/boot.o
cargo build --manifest-path $KERNELDIR/Cargo.toml -Z build-std=core --target=$ARCHDIR/target.json --release
ld -n -T $ARCHDIR/link.ld --gc-sections $BUILDDIR/boot.o $KERNELDIR/target/target/release/libkernel.a -o $BUILDDIR/kernel.bin
mkdir -p $BUILDDIR/image/boot/grub
cp $BUILDDIR/kernel.bin $BUILDDIR/image/boot/kernel.bin
cp $ARCHDIR/grub.cfg $BUILDDIR/image/boot/grub/grub.cfg
grub-mkrescue -o $BUILDDIR/image.iso $BUILDDIR/image
