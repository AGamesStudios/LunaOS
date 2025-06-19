# Running LunaOS in a Virtual Machine

This guide explains how to set up a Linux virtual machine on a Windows host so you can build and run LunaOS.

## 1. Install virtualization software

Download and install [VirtualBox](https://www.virtualbox.org/) or any similar hypervisor such as VMware Workstation Player.

## 2. Create a Linux VM

1. Download an ISO of a lightweight Linux distribution (for example [Ubuntu](https://ubuntu.com/download/desktop)).
2. Create a new virtual machine in your hypervisor and attach the ISO to install the OS.
3. Once installed, boot the VM and ensure it has an Internet connection.

## 3. Prepare the environment

Inside the VM, install the required tools:

```bash
sudo apt-get update
sudo apt-get install git build-essential qemu-system-x86 wget cpio
```

Clone the LunaOS repository inside the VM. You can use the public repository
directly:

```bash
git clone https://github.com/OpenAI/LunaOS.git
cd LunaOS
```

If you forked the project, replace the URL with your fork (without the `<>`
markers).

## 4. Build and run

Use the provided script to build and launch LunaOS under QEMU:

```bash
bash scripts/build.sh
qemu-system-x86_64 -kernel output/bzImage \
    -drive file=output/rootfs.ext2,format=raw,index=0,media=disk \
    -append "root=/dev/sda console=ttyS0" -nographic
```

You should see the system boot in the terminal. For manual kernel and BusyBox compilation, see [MANUAL_BUILD.md](MANUAL_BUILD.md).
To try a tiny bare-metal demonstration instead of Linux, follow [BAREMETAL.md](BAREMETAL.md).
