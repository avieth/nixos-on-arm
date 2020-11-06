{ config, pkgs, lib, ... }:
with lib;
{
  imports = [
    ../mini
  ];

  # SSH
  services.openssh.enable = mkDefault true;
  services.openssh.permitRootLogin = mkDefault "yes";

  # DNS
  services.resolved.enable = false;
  services.resolved.dnssec = "false";

  # set a default root password
  users.users.root.initialPassword = lib.mkDefault "toor";
}
