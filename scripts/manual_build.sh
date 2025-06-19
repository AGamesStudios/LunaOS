#!/bin/bash
set -e

# Directory for build artifacts
WORKDIR="$(pwd)/manual_build"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# Fetch and build the Linux kernel
if [ ! -d linux ]; then
    wget -qO- https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz | tar -xJ
    mv linux-6.6 linux
fi
cd linux
make defconfig
make -j"$(nproc)"
cd ..

# Fetch and build BusyBox
if [ ! -d busybox ]; then
    wget -qO- https://busybox.net/downloads/busybox-1.36.1.tar.bz2 | tar -xj
    mv busybox-1.36.1 busybox
fi
cd busybox
make defconfig
make CONFIG_PREFIX="$WORKDIR/rootfs" install
cd ..

# Create minimal root filesystem
mkdir -p rootfs/dev rootfs/proc rootfs/sys
sudo mknod -m 600 rootfs/dev/console c 5 1
sudo mknod -m 666 rootfs/dev/null c 1 3

cat <<'INIT' > rootfs/init
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
echo "Welcome to your custom Linux"
exec /bin/sh
INIT
chmod +x rootfs/init

find rootfs | cpio -o --format=newc | gzip > initramfs.cpio.gz

echo "Build complete. Boot with:"
echo "qemu-system-x86_64 -kernel linux/arch/x86/boot/bzImage -initrd initramfs.cpio.gz -nographic"

