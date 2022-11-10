# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:
{
  nixpkgs     = import ./config/nixpkgs.nix { inherit config pkgs; };
  services    = import ./config/services.nix { inherit config pkgs; };
  networking  = import ./config/networking.nix { inherit config pkgs; };
  environment = import ./config/environment.nix { inherit config pkgs; };
  programs    = import ./config/programs.nix { inherit config pkgs; };
  users       = import ./config/users.nix { inherit config pkgs; };

  nix = {
    useSandbox = true;
    binaryCaches = [];
  };

  system = {
    stateVersion = "19.09"; # Did you read the comment?
    # Auto upgrade system
    autoUpgrade.enable = true;
    autoUpgrade.channel = "https://nixos.org/channels/nixos-22.05/";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelModules = [ "snd-seq" "snd-rawmidi" ];
  };

  hardware = {
#    enableAllFirmware = true;

#    pulseaudio = {
#      enable = true;
#      package = pkgs.pulseaudio.override { jackaudioSupport = true; };
#      extraConfig = ''
#        load-module module-jack-sink
#        load-module module-jack-source
#        '';
#    };
#
#    brightnessctl.enable = true;
  };

  fileSystems."/" = {
    fsType = "ext4";
    device = "/dev/sda";
  };

  systemd.user.services.pulseaudio.environment = {
#    JACK_PROMISCUOUS_SERVER = "jackaudio";
  };

  imports =
    [ # Include the results of the hardware scan.
#      ./hardware-configuration.nix
#      ./cachix.nix
    ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  time = {
    timeZone = "Asia/Jerusalem";
  };

  sound = {
    enable = true;
  };

  virtualisation = {
    virtualbox.host.enable = true;

    docker.enable = true;
  };
}
