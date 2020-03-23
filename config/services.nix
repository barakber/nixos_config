{ config, pkgs, ... }:
let
  services = {
    openssh = {
      enable = true;
    };

    xserver = import ./services/xserver.nix { inherit config pkgs; };

    urxvtd = {
      enable = true;
    };

    mpd = {
      enable = true;
      musicDirectory = "/home/barak/Music";
    };

    nscd = {
      enable = true;
    };

    resolved = {
      enable = true;
      dnssec = "false";
      fallbackDns = [ "8.8.8.8" "2001:4860:4860::8844" ];
    };

    jack = {
      jackd.enable = true;
    };

    compton = {
      enable = true;
    };

    samba = import ./services/samba.nix { inherit config pkgs; };
  };
in
  services
