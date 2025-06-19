# Bare Metal LunaOS

This example demonstrates how to build a minimal operating system from scratch without relying on the Linux kernel.
It uses [GRUB](https://www.gnu.org/software/grub/) to load a tiny 32‑bit kernel that prints a message to the screen.

## Requirements
- `gcc`, `nasm`, `ld`, and `grub-mkrescue` available on your host
- `qemu-system-i386` to run the ISO image

## Building
From the repository root run:
```bash
bash scripts/baremetal_build.sh
```
This produces `baremetal/LunaOS.iso` which can be booted with QEMU.

## Running
```bash
qemu-system-i386 -cdrom baremetal/LunaOS.iso
```
You should see the text `Hello from LunaOS baremetal!` displayed in the virtual machine window.
