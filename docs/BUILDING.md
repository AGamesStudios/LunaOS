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
The script clones Buildroot, uses `qemu_x86_64_defconfig` to configure a minimal
system, and builds everything. The build can take several minutes. When it
finishes, the resulting kernel, filesystem, and ISO image are placed in the
`output` directory. The script then starts QEMU automatically.

You can later boot the ISO again with:
```bash
bash scripts/run.sh
```

## Customization

Modify the Buildroot configuration in `scripts/build.sh` to enable packages or
adjust kernel options. Consult the Buildroot manual for additional features.
