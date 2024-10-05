# dotfiles

##

- hosts
 - common-hosts
 - common-home
 - HOST
  - default
  - disko
  - hardware
  - home
- modules
 - nixos
 - home-manager

## Partitioning

Dualboot
```bash

```

## Install

```bash
# to reset flake cache (updated repo)
--refresh

# install with disko-install + nixos-install (and print to stdout + log.txt)
nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake 'github:jhwshin/dotfiles#HOST' --disk main '/dev/<sdX>' 2>&1 | tee log.txt

# install disko-install
sudo nix --extra-experimental-features 'nix-command flakes' run github:nix-community/disko -- --mode disko --flake github:jhwshin/dotfiles#khas

# install with nixos-install
nixos-install --root /mnt --flake github:jhwshin/dotfile#HOST

# set password for root
mount /dev/<sdXY> /mnt # if not mounted
nixos-enter --root /mnt -c 'passwd'

# if you want to generate hardware configs
nixos-generate-config --dir <PATH> --root /mnt
# --no-filesystems
# --no-hardware-scan
# --show-hardware-config
```

```bash
fdisk /dev/<sdX>

git clone https://github.com/jhwshin/dotfiles

nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake '.#HOST' --disk main '/dev/<sdX>' 2>&1 | tee log.txt

mount /dev/<sdXY> /mnt
mount /dev/<sdXY> /mnt/boot
```

## Rebuild

```bash
# nixosConfiguration
nixos-rebuild switch --flake github:jhwshin/dotfiles#HOST
nixos-rebuild switch --flake .#HOST

# homeConfigurations
home-manager switch --flake github:jhwshin/dotfiles#USERNAME@HOST
home-manager switch --flake .#USERNAME@HOST

# to roll back
nixos-rebuild --rollback

# will change but rollback on boot
nixos-rebuild test --flake 

# update packages and lock
nix flake update

# delete older
nix-collect-garbage -d

# optimize nix store (dedupes)
nix-store --optimize

# /nix/var/nix/profiles/ for system versions
nix-env --list-generations --profile /nix/var/nix/profiles/system
```

## Nix

```bash
# run flake
nix run github:jhwshin/dotfiles#packageName

nix run nixpkgs#<PACKAGE> <COMMAND>
nix shell nixpkgs#<PACKAGE> -c <COMMAND>
nix shell -p p1 p2 ...
```

## TODO

- [O] configuration.nix
- [O] hardware-configuration.nix
- [O] flakes
- [O] home-manager
- [O] multiple hosts
- [O] disko
- [] impermanence
- [] btrfs
- [] luks
- [] port arch configs stuff to nixos
- [] modules
- [] secrets

---

programs.git.enable
users.users.<name?>.shell

hardware.bluetooth.enable
services.bluetooth.enable
services.blueman.enable

---

home-manager

services.barrier.client.enable