{
  disko.devices.disk = {
    main = {
      type = "disk";
      device = "/dev/vda";
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
              mountOptions = [ "defaults" "umask=0077" ];
            };
          };

          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              askPassword = true;
              extraFormatArgs = [
                "--hash sha512"
                "--pbkdf argon2id"
                "--use-random"
                "--key-size 512"
                "--pbkdf-memory 1048576"
                "--pbkdf-parallel 4"
                "--iter-time 2000"
                "--cipher aes-xts-plain64"
                "--label cryptroot"
              ];
              extraOpenArgs = [
                "--perf-no_read_workqueue"
                "--perf-no_write_workqueue"
              ];
              settings = {
                allowDiscards = true;
              };

              content = {
                type = "btrfs";
                extraArgs = [ "-f" "-L" "root" ];
                subvolumes = {

                  "/" = {
                    mountpoint = "/.btrfsroot";
                    mountOptions = [ "subvolid=5" "defaults" "compress=zstd:3" "noatime" "nodiratime" ];
                  };

                  "@" = {
                    mountpoint = "/";
                    mountOptions = [ "subvol=/@" "defaults" "compress=zstd:3" "noatime" "nodiratime" ];
                  };

                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "subvol=/@home" "defaults" "compress=zstd:3" "noatime" "nodiratime" ];
                  };

                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "subvol=/@nix" "defaults" "compress=zstd:3" "noatime" "nodiratime" ];
                  };

                  "@swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile ={
                      size = "8G";
                      path = "swapfile";
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