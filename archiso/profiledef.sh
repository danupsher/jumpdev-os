#!/usr/bin/env bash
# shellcheck disable=SC2034

# JumpDev OS Archiso Profile Definition
# See: https://wiki.archlinux.org/title/Archiso

iso_name="jumpdev"
iso_label="JUMPDEV_$(date +%Y%m)"
iso_publisher="JumpDev OS <https://github.com/danupsher/jumpdev-os>"
iso_application="JumpDev OS Live Environment"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
           'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/gshadow"]="0:0:400"
  ["/etc/sudoers.d/wheel"]="0:0:440"
  ["/root"]="0:0:750"
  ["/home/jump"]="1000:1000:750"
)
