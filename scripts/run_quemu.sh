#!/bin/bash

# QEMU VM Launch Script

# Path to the kernel image
build/tmp/deploy/images/qemux86-64
KERNEL_IMG="../build/tmp/deploy/images/qemux86-64/bzImage-qemux86-64.bin"

# Path to the root filesystem image
ROOTFS_IMG="../build/tmp/deploy/images/qemux86-64/core-image-sato-qemux86-64-20240308193614.rootfs.ext4"

# Start QEMU
qemu-system-x86_64 \
    -enable-kvm \
    -m 1024 \
    -cpu host \
    -smp cores=2 \
    -kernel "${KERNEL_IMG}" \
    -drive file="${ROOTFS_IMG}",if=virtio,format=raw \
    -net nic,model=virtio -net user,hostfwd=tcp::2222-:22 \
    -usb \
    -device usb-tablet \
    -device usb-kbd \
    -vga virtio \
    -display sdl,gl=on \
    -device virtio-rng-pci \
    -append "root=/dev/vda console=tty1 console=ttyS0" \
    -serial stdio 