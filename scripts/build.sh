#!/bin/bash
set -e

# Clone Buildroot if not already present
if [ ! -d buildroot ]; then
    git clone --depth=1 https://github.com/buildroot/buildroot.git
fi

cd buildroot

# Use Buildroot's QEMU-ready configuration
make qemu_x86_64_defconfig

# Build the system
make

# Copy output
mkdir -p ../output
cp output/images/bzImage ../output/
cp output/images/rootfs.ext2 ../output/
if [ -f output/images/rootfs.iso9660 ]; then
    cp output/images/rootfs.iso9660 ../output/LunaOS.iso
fi

cd ..
echo "Starting LunaOS under QEMU..."
bash scripts/run.sh
