#!/bin/bash
set -e

# Clone Buildroot if not already present
if [ ! -d buildroot ]; then
    git clone --depth=1 https://github.com/buildroot/buildroot.git
fi

cd buildroot

# Use Buildroot's default x86_64 configuration
make qemu_x86_64_defconfig

# Build the system
make

# Copy output
mkdir -p ../output
cp output/images/bzImage ../output/
cp output/images/rootfs.ext2 ../output/

cd ..
echo "Starting LunaOS under QEMU..."
qemu-system-x86_64 -kernel output/bzImage \
    -drive file=output/rootfs.ext2,format=raw,index=0,media=disk \
    -append "root=/dev/sda console=ttyS0" -nographic
