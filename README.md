# dotfiles

```
sudo nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake github:jhwshin/dotfiles#khas --disk main /dev/vda 2>&1 | tee log.txt
```