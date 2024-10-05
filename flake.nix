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
    nixosConfigurations = {
      raszagal = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/raszagal
          disko.nixosModules.disko
          {
            disko.devices = {
              disk = {
                main = {

                  device = "/dev/vda";
                  type = "disk";

                  content = {

                    type = "gpt";
                    partitions = {

                      ESP = {
                        label = "";
                        type = "EF00";
                        size = "2G";
                        content = {
                          type = "filesystem";
                          format = "vfat";
                          mountpoint = "/boot";
                          mountOptions = [ "umask=0077" ];
                        };
                      };

                      luks = {
                        label = "luks";
                        size = "100%";
                        content = {
                          type = "luks";
                          name = "cryptroot";
                          extraOpenArgs = [
                            # "--allow-discards"
                            "--perf-no_read_workqueue"
                            "--perf-no_write_workqueue"
                          ];
                          settings = {
                            allowDiscards = true;
                          };

                          content = {
                            type = "btrfs";
                            extraArgs = [
                              "-L"
                              "nixos"
                              "-f"
                            ];
                            subvolumes = {
                              "/" = {
                                mountpoint = "/.btrfsroot";
                                mountOptions = [
                                  "subvol=/" "defaults" "noatime"
                                ];
                              };
                              "@" = {
                                mountpoint = "/";
                                mountOptions = [
                                  "subvol=@" "defaults" "noatime"
                                ];
                              };
                              "@home" = {
                                mountpoint = "/home";
                                mountOptions = [
                                  "subvol=@home" "defaults" "noatime"
                                ];
                              };
                              "@nix" = {
                                mountpoint = "/nix";
                                mountOptions = [
                                  "subvol=@home" "defaults" "noatime"
                                ];
                              };
                              "@swap" = {
                                mountpoint = "/.swapvol";
                                swap.swapfile.size = "1024M";
                              };
                            };
                          };
                        };
                      };
                    };
                  };
                };
              };
            };

          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hws = import ./hosts/raszagal/home.nix;
          }
        ];
      };
    };

    homeConfigurations = {
      "hws@raszagal" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/raszagal/home.nix
        ];
      };
    };
  };
}