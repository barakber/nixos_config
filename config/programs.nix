{ config, pkgs, ... }:
let
  programs = {
    zsh = import ./programs/zsh.nix { inherit config pkgs; };

    chromium = import ./programs/chromium.nix { inherit config pkgs; };

    firejail = {
      enable = true;
    };
  };
in
  programs
