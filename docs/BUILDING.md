# Building LunaOS

This project provides a basic template to create your own Linux-based system using [Buildroot](https://buildroot.org/).

## Requirements
- A Linux environment with `git` and standard build tools (gcc, make, etc.).
  Windows users can install [WSL](https://learn.microsoft.com/windows/wsl/) or
  run a Linux virtual machine.
- QEMU to run the resulting image (on Debian-based systems:
  `sudo apt-get install qemu-system-x86`)

## Quick Start

From the repository root run:
```bash
bash scripts/build.sh
```
The script clones Buildroot, builds a minimal image and creates an `output` directory containing a kernel, a root filesystem and an ISO (`output/LunaOS.iso`). It then starts QEMU automatically.

You can later boot the ISO again with:
```bash
bash scripts/run.sh
```

## Customization

Modify the Buildroot configuration in `scripts/build.sh` to enable packages or
adjust kernel options. Consult the Buildroot manual for additional features.
