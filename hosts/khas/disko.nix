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
              label = "";
              type = "EF00";
              size = "2G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            root = {
              label = "luks";
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];
                settings = {

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
                    }
                    "@" = {
                      mountpoint = "/";
                      mountOptions = [
                        "subvol=@" "defaults" "noatime"
                      ];
                    }
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "subvol=@home" "defaults" "noatime"
                      ];
                    }
                  }
                };
              };
            };
          };
        };
      };
    };
  };
}