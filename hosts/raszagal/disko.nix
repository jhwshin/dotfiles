{...}:
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
              type = "EF00";
              size = "2G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "rootfs" = {
                    mountpoint = "/";
                  };
                  "/home" = {
                    mountOption = [ "" ];
                    mountpoint = "/home";
                  };
                  "/nix" = {
                    mountOptions = [];
                    mountpoint = "/nix";
                  };
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap = {
                      swapfile.size = "";
                      swapfile.path = "rel-path";
                    };
                  };
                };
              };
            };
            # root = {
            #   size = "100%";
            #   content = {
            #     type = "filesystem";
            #     format = "ext4";
            #     mountpoint = "/";
            #   };
            # };
          };
        };
      };
    };
  };
}