{ config, pkgs, ... }:
with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    aiohttp
    pywal
    pygame
    pillow
    requests
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
  {
    imports =
      [
        ./hardware-configuration.nix
        ./networking.nix
        ./users.nix
      ];

    i18n = {
      consoleFont = "Lat2-Terminus16";
      consoleKeyMap = "fr";
      defaultLocale = "fr_FR.UTF-8";
    };

    # Time zone
    time.timeZone = "Europe/Zurich";

    # Packages
    environment.systemPackages = with pkgs; [
      wget git python-with-my-packages
    ];

    programs.fish.enable = true;
    systemd.services = {
        polymath = import ./services/polymath.nix { inherit pkgs; };
    };

    # System
    boot = {
      kernelParams = [ "net.ifnames=0" "biosdevname=0" ];
      kernelPackages = pkgs.linuxPackages_latest;
      cleanTmpDir = true;
    };
    system.stateVersion = "19.09";

  }

