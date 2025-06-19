# Manual Build Process

This guide explains how to create a tiny Linux environment without Buildroot.
You will compile the kernel and BusyBox, assemble a minimal initramfs and run it
with QEMU.

## Requirements
- A Linux host with standard build tools (`gcc`, `make`, `wget`, etc.). Windows
  users can install [WSL](https://learn.microsoft.com/windows/wsl/) or build
  inside a Linux virtual machine (see [VM_SETUP.md](VM_SETUP.md)) to obtain a
  Linux environment.
- Root privileges to create device nodes
- QEMU (`sudo apt-get install qemu-system-x86` on Debian-based systems)

## Steps
1. Create a directory for the build and enter it:
   ```bash
   mkdir -p manual_build && cd manual_build
   ```
2. Download and build the Linux kernel:
   ```bash
   wget -qO- https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz | tar -xJ
   mv linux-6.6 linux
   cd linux
   make defconfig
   make -j"$(nproc)"
   cd ..
   ```
3. Download and build BusyBox:
   ```bash
   wget -qO- https://busybox.net/downloads/busybox-1.36.1.tar.bz2 | tar -xj
   mv busybox-1.36.1 busybox
   cd busybox
   make defconfig
   make CONFIG_PREFIX="$(pwd)/../rootfs" install
   cd ..
   ```
4. Assemble a minimal root filesystem:
   ```bash
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
   ```
5. Create the initramfs archive:
   ```bash
   find rootfs | cpio -o --format=newc | gzip > initramfs.cpio.gz
   ```
6. Boot the system with QEMU:
   ```bash
   qemu-system-x86_64 -kernel linux/arch/x86/boot/bzImage \
       -initrd initramfs.cpio.gz -nographic
   ```

When the virtual machine starts, you will be dropped into a BusyBox shell.

For an even smaller proof‑of‑concept that skips the Linux kernel entirely,
see [BAREMETAL.md](BAREMETAL.md).
