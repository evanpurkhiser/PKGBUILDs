#!/usr/bin/env bash

# Runs inside the publish container to import the signing key and create
# a signed pacman repo database from newly built package artifacts.

set -euo pipefail

shopt -s nullglob

if [[ -z "${GPG_PACKAGE_SIGNING_KEY:-}" ]]; then
	echo "GPG_PACKAGE_SIGNING_KEY secret is not set."
	exit 1
fi

if [[ -z "${REPO_DB_NAME:-}" ]]; then
	echo "REPO_DB_NAME is not set."
	exit 1
fi

printf "%s\n" "$GPG_PACKAGE_SIGNING_KEY" | gpg --batch --import

signing_key_fpr=$(gpg --list-secret-keys --with-colons | awk -F: '/^fpr:/ {print $10; exit}')
if [[ -z "$signing_key_fpr" ]]; then
	echo "Failed to determine signing key fingerprint."
	exit 1
fi

new_repo_pkgs=()
for pkg in new-artifacts/*.pkg.tar.zst; do
	new_repo_pkgs+=("repo/x86_64/$(basename "$pkg")")
done

if [[ ${#new_repo_pkgs[@]} -eq 0 ]]; then
	echo "No newly built package artifacts were found."
	exit 1
fi

repo-add --remove --sign --key "$signing_key_fpr" "repo/x86_64/${REPO_DB_NAME}.db.tar.zst" "${new_repo_pkgs[@]}"

# repo-add renames the previous db/files archives to *.old (and signs them)
# as local backups. We don't want those in the published release.
rm -f repo/x86_64/*.old repo/x86_64/*.old.sig
