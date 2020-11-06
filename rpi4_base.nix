let

  # Need a custom patch set.
  nixpkgsSrc = builtins.fetchGit {
    url = "https://github.com/avieth/nixpkgs";
    ref = "avieth/rpi_cross";
    rev = "072e0e93f3d218d87499374d5c7d2b86399ce771";
  };

  nixos = import (nixpkgsSrc + /nixos) {
    configuration = { ... }: {
      imports = [
        <machine>
        <image>
      ];

      # Patch the bind utility so that it cross compiles.
      nixpkgs.overlays = [
        (self: super: {
          bind = super.bind.overrideAttrs (oldAttrs: {
            patches = [./bind.patch] ++ oldAttrs.patches;
          });
        })
      ];

      networking.wireless.enable = false;
      hardware.bluetooth.enable = false;

      networking.hostName = "your-new-rpi-4";
      networking.enableIPv6 = true;
      networking.useDHCP = true;

      # Throw some extra stuff in here, like users with authorized SSH keys
      # for example.

    };
  };
in
nixos.config.system.build.sdImage // {
  inherit (nixos) pkgs system config;
}
