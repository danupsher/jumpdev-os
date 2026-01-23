#!/bin/bash
# JumpDev OS - QEMU Test Environment
# Boots the ISO in a VM for testing without writing to USB

ISO_PATH="${1:-/home/dan/projects/jumpdev-os/runner/_work/jumpdev-os/jumpdev-os/out/jumpdev-*.iso}"
SSH_PORT="${2:-2222}"
VNC_PORT="${3:-5900}"

# Find the latest ISO if glob pattern
ISO=$(ls -t $ISO_PATH 2>/dev/null | head -1)

if [ -z "$ISO" ] || [ ! -f "$ISO" ]; then
    echo "Error: ISO not found at $ISO_PATH"
    echo "Usage: $0 [iso_path] [ssh_port] [vnc_port]"
    exit 1
fi

echo "Booting: $ISO"
echo "SSH: localhost:$SSH_PORT (user: jump, no password)"
echo "VNC: localhost:$VNC_PORT"
echo ""
echo "Connect via: ssh -p $SSH_PORT jump@localhost"
echo "Or VNC to: localhost:$VNC_PORT"
echo ""

# Run QEMU with:
# - KVM acceleration
# - 4GB RAM, 2 CPUs
# - Virtio network with SSH port forwarding
# - VNC display
# - UEFI boot (OVMF)
qemu-system-x86_64 \
    -enable-kvm \
    -m 4G \
    -smp 2 \
    -cpu host \
    -cdrom "$ISO" \
    -boot d \
    -netdev user,id=net0,hostfwd=tcp::${SSH_PORT}-:22 \
    -device virtio-net-pci,netdev=net0 \
    -vga virtio \
    -display vnc=:0 \
    -bios /usr/share/qemu/OVMF.fd \
    -name "JumpDev OS Test"
