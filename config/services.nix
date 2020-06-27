{ config, pkgs, ... }:
let
  services = {
    openssh = {
      enable = true;
    };

    xserver = import ./services/xserver.nix { inherit config pkgs; };

    urxvtd = {
      enable = true;
      package = pkgs.rxvt_unicode-with-plugins;
    };

    xrdp = {
      enable = true;
      defaultWindowManager = "${pkgs.icewm}/bin/icewm";
    };

    #mpd = {
      #enable = true;
      #musicDirectory = "/home/barak/Music";
    #};

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
      # support ALSA only programs via ALSA JACK PCM plugin
      alsa.enable = false;
      # support ALSA only programs via loopback device (supports programs like Steam)
      loopback = {
        enable = true;
        # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
        #dmixConfig = ''
        #  period_size 2048
        #'';
      };
    };

    compton = {
      enable = true;
    };

    samba = import ./services/samba.nix { inherit config pkgs; };
  };
in
  services
