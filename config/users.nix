{ config, pkgs, ... }:
let
  users = {
    mutableUsers = true; # DO NOT CHANGE! LOCKS YOU OUT WITH NO LOGIN

    users.barak = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "networkmanager" "docker" "video" "jackaudio" "audio" "sound" "input" "tty" ]; # Enable ‘sudo’ for the user.
      openssh.authorizedKeys.keys = (import ./private.nix { inherit config pkgs; }).keys;
    };

  };
in
  users
