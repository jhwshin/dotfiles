{
  description = "jhwshin's nix dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    disko,
    ...
  } @ inputs: let
    inherit (self) outputs;

    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      # "aarch64-darwin"
      # "x86_64-darwin"
    ];
  in {

    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      khas = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/khas/configuration.nix
          disko.nixosModules.disko {
            disko.devices = {
                disk = {
                    main = {
                        device = "/dev/vda";
                        type = "disk";
                        content = {
                            type = "gpt";
                            partitions = {
                                ESP = {
                                    type = "EF00";
                                    size = "2GB";
                                    content = {
                                        type = "filesystem";
                                        format = "vfat";
                                        mountpoint = "/boot";
                                    };
                                };
                                root = {
                                    size = "100%";
                                    content = {
                                        type = "filesystem";
                                        format = "ext4";
                                        mountpoint = "/";
                                    };
                                };
                            };
                        };
                    };
                };
            };
          };
        ];
      };
    };
    # $ sudo nix run 'github:nix-community/disko#disko-install' -- --flake '/tmp/config/etc/nixos#mymachine' --disk main /dev/sda
    # nix shell nixpkgs#home-manager
    # Available through 'home-manager switch --flake .#your-username@your-hostname'
    homeConfigurations = {
      "hws@khas" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/khas/home.nix
        ];
      };
    };
  };
}
