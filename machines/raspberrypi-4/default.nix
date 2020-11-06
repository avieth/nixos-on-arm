{ pkgs, config, lib, ... }:
let crossSystemBase = lib.systems.examples.aarch64-multiplatform;
    crossSystemPlatformBase = crossSystemBase.platform;
in
{
  # Most of the work is done in the sd-image-aarch64 module.
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix>
  ];

  nixpkgs.crossSystem = crossSystemBase // {
    platform = crossSystemPlatformBase // {
      gcc = {
        cpu = "cortex-a72+crypto";
        # Somehow using this arch doesn't work. Not sure why.
        #arch = "armv8-a+crc";
      };
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_rpi4;

}
