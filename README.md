# dotfiles


## Install

```bash
# to reset flake cache (updated repo)
--refresh

# install with disko-install + nixos-install (and print to stdout + log.txt)
nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake 'github:jhwshin/dotfiles#HOST' --disk main '/dev/<sdX>' 2>&1 | tee log.txt

# install with nixos-install
nixos-install --root /mnt --flake github.com:jhwshin/dotfile#HOST

# set password for root
mount /dev/<sdXY> /mnt # if not mounted
nixos-enter --root /mnt -c 'passwd'

# if you want to generate hardware configs
nixos-generate-config --dir <PATH> --root /mnt
# --no-filesystems
# --no-hardware-scan
# --show-hardware-config
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
