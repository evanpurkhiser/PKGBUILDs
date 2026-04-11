#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
	echo "usage: $(basename "$0") <package-name>" >&2
	exit 2
fi

package="$1"

echo "AUR publish start: ${package}"

if [ -z "${PRIVATE_KEY_AUR:-}" ]; then
	echo "PRIVATE_KEY_AUR is not set" >&2
	exit 2
fi

git config --global --add safe.directory /pkgs

eval "$(ssh-agent -s)" >/dev/null
ssh-add - <<<"${PRIVATE_KEY_AUR}" >/dev/null

mkdir -p "$HOME/.ssh"
echo "aur.archlinux.org ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBLMiLrP8pVi5BFX2i3vepSUnpedeiewE5XptnUnau+ZoeUOPkpoCgZZuYfpaIQfhhJJI5qgnjJmr4hyJbe/zxow=" >>"$HOME/.ssh/known_hosts"

/pkgs/aur-push "/pkgs/${package}"
echo "AUR push completed: ${package}"
git ls-remote "ssh+git://aur@aur.archlinux.org/${package}.git" refs/heads/master | grep -q .
echo "AUR remote verified: ${package}"
