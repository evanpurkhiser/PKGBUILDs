#!/usr/bin/env bash

# Bootstraps the Arch build container as root, prepares a builder user,
# and delegates package compilation/signing to the builder script.

set -euo pipefail

if [[ -z "${GPG_PACKAGE_SIGNING_KEY:-}" ]]; then
	echo "GPG_PACKAGE_SIGNING_KEY secret is not set."
	exit 1
fi

PACKAGE_DIR="${PACKAGE_DIR:-/pkg}"
KEY_FILE="/tmp/gpg-package-signing-key.asc"

if [[ ! -d "$PACKAGE_DIR" ]]; then
	echo "Package directory not found: $PACKAGE_DIR"
	exit 1
fi

cleanup() {
	# Remove the temporary private key export after the build step ends.
	rm -f "$KEY_FILE"
}
trap cleanup EXIT

printf "%s\n" "$GPG_PACKAGE_SIGNING_KEY" >"$KEY_FILE"
chmod 0600 "$KEY_FILE"

pacman-key --init
pacman-key --populate
pacman -Syu --noconfirm
pacman -S --noconfirm git sudo

sed -i '/^OPTIONS=/s/\<debug\>/!debug/' /etc/makepkg.conf

useradd -m builder
echo "builder ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

chown builder:builder "$KEY_FILE"
chown -R builder:builder "$PACKAGE_DIR"

sudo -H -u builder env PACKAGE_DIR="$PACKAGE_DIR" KEY_FILE="$KEY_FILE" \
	/bin/bash /pkgs/.github/scripts/build-package-as-builder.sh
