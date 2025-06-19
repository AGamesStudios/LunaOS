#!/bin/bash
set -e

BASEDIR="$(dirname "$0")/.."
WORKDIR="$BASEDIR/baremetal"
ISO_DIR="$WORKDIR/iso"

mkdir -p "$ISO_DIR/boot/grub"

# Compile kernel
nasm -f elf32 "$WORKDIR/boot.asm" -o "$WORKDIR/boot.o"
gcc -m32 -ffreestanding -c "$WORKDIR/kernel.c" -o "$WORKDIR/kernel.o"
ld -m elf_i386 -T "$WORKDIR/linker.ld" "$WORKDIR/boot.o" "$WORKDIR/kernel.o" -o "$WORKDIR/kernel.bin"

# Prepare grub config
cp "$WORKDIR/kernel.bin" "$ISO_DIR/boot/"
cat > "$ISO_DIR/boot/grub/grub.cfg" <<CFG
set timeout=0
set default=0
menuentry "LunaOS Baremetal" {
    multiboot2 /boot/kernel.bin
    boot
}
CFG

# Create ISO image
grub-mkrescue -o "$WORKDIR/LunaOS.iso" "$ISO_DIR" >/dev/null

echo "Build complete. Boot with:"
echo "qemu-system-i386 -cdrom $WORKDIR/LunaOS.iso"
