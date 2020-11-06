{ config, pkgs, lib, ... }:
let platform = config.nixpkgs.crossSystem.platform.name; in
{
  # this value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "unstable"; # Did you read the comment?

  # custom nixos modules
  imports = [ ../../crosspkgs/modules ];

  # use these overlays to work around cross compilation issues
  nixpkgs.overlays = [
    (self: super: { })
  ];

  networking.hostName = lib.mkDefault "nixos-on-${platform}";
  sdImage.imageBaseName = lib.mkDefault "nixos-on-${platform}";

  environment.systemPackages = [
    pkgs.glibc
    pkgs.coreutils
  ];
}
