## Evan Purkhisers PKGBUILD files

[![Build Status](https://github.com/evanpurkhiser/PKGBUILDs/workflows/build/badge.svg)](https://github.com/evanpurkhiser/PKGBUILDs/actions?query=workflow%3Abuild)

These are my customized PKGBUILD files for use with the Arch Linux packaging
system.

GitHub actions build and publish these packages to the AUR automatically.
Packages are available as build artifacts.

Import the package signing key first:

```bash
sudo pacman-key --keyserver hkps://keyserver.ubuntu.com --recv-keys B5849CBB1122C462550F2B72A04148F92E741E20
sudo pacman-key --lsign-key B5849CBB1122C462550F2B72A04148F92E741E20
```

Then add the rolling GitHub release-backed pacman repo to your
`/etc/pacman.conf`:

```ini
[evanpurkhiser]
SigLevel = Required
Server = https://github.com/evanpurkhiser/PKGBUILDs/releases/download/pacman-repo
```
