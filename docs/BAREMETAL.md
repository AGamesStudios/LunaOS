# Bare Metal LunaOS

This example demonstrates how to build a minimal operating system from scratch without relying on the Linux kernel.
It uses [GRUB](https://www.gnu.org/software/grub/) to load a tiny 32‑bit kernel that prints a message to the screen.

## Requirements
- `gcc`, `nasm`, `ld`, and `grub-mkrescue` available on your host
- `qemu-system-i386` to run the ISO image

## Building
From the repository root run the following commands:
```bash
nasm -f elf32 baremetal/boot.asm -o baremetal/boot.o
gcc -m32 -ffreestanding -c baremetal/kernel.c -o baremetal/kernel.o
ld -m elf_i386 -T baremetal/linker.ld \
    baremetal/boot.o baremetal/kernel.o -o baremetal/kernel.bin
mkdir -p baremetal/iso/boot/grub
cp baremetal/kernel.bin baremetal/iso/boot/
cat > baremetal/iso/boot/grub/grub.cfg <<'EOF'
set timeout=0
set default=0
menuentry "LunaOS Baremetal" {
    multiboot2 /boot/kernel.bin
    boot
}
EOF
grub-mkrescue -o baremetal/LunaOS.iso baremetal/iso >/dev/null
```
This creates `baremetal/LunaOS.iso` which can be booted with QEMU.

## Running
```bash
qemu-system-i386 -cdrom baremetal/LunaOS.iso
```
You should see the text `Hello from LunaOS baremetal!` displayed in the virtual machine window.
