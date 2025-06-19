# Building LunaOS

This project provides a basic template to create your own Linux-based system using [Buildroot](https://buildroot.org/).

## Requirements
- A Linux environment with `git` and standard build tools (gcc, make, etc.)
- QEMU to run the resulting image (on Debian-based systems: `sudo apt-get install qemu-system-x86`)

## Quick Start

From the repository root run:
```bash
bash scripts/build.sh
```
The script clones Buildroot, builds a minimal image and creates an `output` directory containing the bootable kernel and root filesystem.

You can test the image with QEMU:
```bash
qemu-system-x86_64 -kernel output/bzImage -drive file=output/rootfs.ext2,format=raw,index=0,media=disk -append "root=/dev/sda console=ttyS0" -nographic
```

## Customization

Modify the Buildroot configuration in `scripts/build.sh` to enable packages or adjust kernel options. Consult the Buildroot manual for additional features.

For a step-by-step manual build process that compiles the kernel and BusyBox without Buildroot, see [MANUAL_BUILD.md](MANUAL_BUILD.md).
