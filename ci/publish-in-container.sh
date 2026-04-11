#!/usr/bin/env bash

set -euo pipefail

pacman-key --init
pacman-key --populate
pacman -Syu --noconfirm
pacman -S --noconfirm openssh git sudo

useradd -m builder
echo "builder ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
chown -R builder:builder /pkgs

sudo -H -u builder env PRIVATE_KEY_AUR="$PRIVATE_KEY_AUR" /pkgs/ci/publish-aur.sh "$PACKAGE"
