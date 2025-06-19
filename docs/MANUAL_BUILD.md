# Manual Build Process

This guide explains how to create a tiny Linux environment without Buildroot.
You will compile the kernel and BusyBox, assemble a minimal initramfs and run it
with QEMU.

## Requirements
- A Linux host with standard build tools (`gcc`, `make`, `wget`, etc.)
- Root privileges to create device nodes

## Steps
1. Run `./scripts/manual_build.sh`. The script downloads kernel and BusyBox
   sources, builds them and produces `initramfs.cpio.gz` under `manual_build/`.
2. Boot the system with QEMU:
   ```bash
   qemu-system-x86_64 -kernel manual_build/linux/arch/x86/boot/bzImage \
       -initrd manual_build/initramfs.cpio.gz -nographic
   ```

When the virtual machine starts, you will be dropped into a BusyBox shell.
