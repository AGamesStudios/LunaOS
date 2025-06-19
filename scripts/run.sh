#!/bin/bash
set -e

if [ -f output/LunaOS.iso ]; then
    echo "Booting LunaOS from ISO..."
    qemu-system-x86_64 -cdrom output/LunaOS.iso -boot d -nographic
elif [ -f output/bzImage ] && [ -f output/rootfs.ext2 ]; then
    echo "Booting LunaOS from kernel and rootfs..."
    qemu-system-x86_64 -kernel output/bzImage \
        -drive file=output/rootfs.ext2,format=raw,index=0,media=disk \
        -append "root=/dev/sda console=ttyS0" -nographic
else
    echo "No build artifacts found. Run scripts/build.sh first." >&2
    exit 1
fi
