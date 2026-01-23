#!/usr/bin/env bash
# JumpDev OS - Customize airootfs script
# This runs during ISO build to configure the live system

set -e

# Generate locales
locale-gen

# Ensure jump user owns their home directory
chown -R 1000:1000 /home/jump
