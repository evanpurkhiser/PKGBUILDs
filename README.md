## Evan Purkhisers PKGBUILD files

[![Build Status](https://github.com/evanpurkhiser/PKGBUILDs/workflows/build/badge.svg)](https://github.com/evanpurkhiser/PKGBUILDs/actions?query=workflow%3Abuild)

These are my customized PKGBUILD files for use with the Arch Linux packaging
system.

GitHub actions build and publish these packages to the AUR automatically.
Packages are available as build artifacts.

You can also add the rolling GitHub release-backed pacman repo to your
`/etc/pacman.conf`:

```ini
[evanpurkhiser]
SigLevel = Optional TrustAll
Server = https://github.com/evanpurkhiser/PKGBUILDs/releases/download/pacman-repo
```
