#!/usr/bin/env bash

set -euo pipefail

pacman-key --init
pacman-key --populate
pacman -Syu --noconfirm
pacman -S --noconfirm openssh git sudo

useradd -m builder
echo "builder ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
chown -R builder:builder /pkgs

sudo -u builder -E /pkgs/ci/publish-aur.sh "$PACKAGE"
