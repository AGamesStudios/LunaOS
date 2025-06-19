# Building LunaOS

This project provides a basic template to create your own Linux-based system using [Buildroot](https://buildroot.org/).

## Requirements
- A Linux environment with `git` and standard build tools (gcc, make, etc.)

## Quick Start

Run `./scripts/build.sh` to clone Buildroot and build a minimal image. The script creates an `output` directory containing the bootable image and root filesystem.

You can test the image with QEMU:
```bash
qemu-system-x86_64 -kernel output/bzImage -drive file=output/rootfs.ext2,format=raw,index=0,media=disk -append "root=/dev/sda console=ttyS0" -nographic
```

## Customization

Modify the Buildroot configuration in `scripts/build.sh` to enable packages or adjust kernel options. Consult the Buildroot manual for additional features.
