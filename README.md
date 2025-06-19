# LunaOS

LunaOS is a minimal Linux-based operating system template. This repository shows
how to build a small custom distribution using Buildroot. It provides a simple
script to fetch Buildroot, compile the kernel and root filesystem, and run it in
QEMU. The build scripts expect a Linux environment. Windows users should install
[WSL](https://learn.microsoft.com/windows/wsl/) or build inside a Linux virtual
machine. See [docs/VM_SETUP.md](docs/VM_SETUP.md) for an example VM workflow.

## Getting the source
Clone the repository on a Linux system with Git installed:

```bash
git clone https://github.com/OpenAI/LunaOS.git
cd LunaOS
```


## Usage
Install QEMU (`sudo apt-get install qemu-system-x86` on Debian-based systems) and run the build script:
```bash
bash scripts/build.sh
```

See [docs/BUILDING.md](docs/BUILDING.md) for the Buildroot-based method. If you prefer to compile everything manually, follow [docs/MANUAL_BUILD.md](docs/MANUAL_BUILD.md).
For a tiny bare-metal example that does not use the Linux kernel, check
[docs/BAREMETAL.md](docs/BAREMETAL.md).
