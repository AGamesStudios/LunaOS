# LunaOS

LunaOS is a minimal Linux-based operating system template. This repository
contains a script that downloads Buildroot, compiles a small kernel and root
filesystem, and places the result in the `output` directory. The script expects
a Linux environment. Windows users can install
[WSL](https://learn.microsoft.com/windows/wsl/) or run a Linux virtual machine.

## Getting the source
Clone the repository on a Linux system with Git installed:

```bash
git clone https://github.com/OpenAI/LunaOS.git
cd LunaOS
```


## Building and running
Install QEMU (`sudo apt-get install qemu-system-x86` on Debian-based systems)
and execute the build script:
```bash
bash scripts/build.sh
```

The script automatically starts QEMU once the build completes. An ISO image is
left in `output/LunaOS.iso` if you want to boot it manually later:
```bash
bash scripts/run.sh
```

See [docs/BUILDING.md](docs/BUILDING.md) for details on customizing the build.
