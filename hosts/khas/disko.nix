{
    disko.devices = {
        disk = {
            main = {
                device = "/dev/vda";
                type = "disk";
                content = {
                    type = "table";
                    format = "msdos";
                    partitions = [
                        {
                            name = "root";
                            part-type = "primary";
                            start = "1M";
                            end = "100%";
                            bootable = true;
                            content = {
                                type = "filesystem";
                                format = "ext4";
                                mountpoint = "/";
                            };
                        };
                    ];
                };
            };
        };
    };
}