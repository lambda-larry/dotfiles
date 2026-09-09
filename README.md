# Dotfiles

## Installation

This repo deploys dotfiles with GNU Make and GNU coreutils.

```bash
make
```

Custom prefix can be specified for chroot or testing
```bash
make PREFIX=${HOME}
make PREFIX=${PWD}/local
make PREFIX=/mnt/gentoo/home/${USER}
```
