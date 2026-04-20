#!/usr/bin/env bash

# Runs as the non-root builder user inside the container to import the
# signing key and produce signed package artifacts with makepkg.

set -euo pipefail

PACKAGE_DIR="${PACKAGE_DIR:-/pkg}"
KEY_FILE="${KEY_FILE:-/tmp/gpg-package-signing-key.asc}"

if [[ ! -d "$PACKAGE_DIR" ]]; then
	echo "Package directory not found: $PACKAGE_DIR"
	exit 1
fi

if [[ ! -f "$KEY_FILE" ]]; then
	echo "Signing key file not found: $KEY_FILE"
	exit 1
fi

gpg --batch --import "$KEY_FILE"
signing_key_fpr=$(gpg --list-secret-keys --with-colons | awk -F: '/^fpr:/ {print $10; exit}')

if [[ -z "$signing_key_fpr" ]]; then
	echo "Failed to determine signing key fingerprint."
	exit 1
fi

cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

cd "$PACKAGE_DIR"
makepkg -s --noconfirm --sign --key "$signing_key_fpr"
