  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
