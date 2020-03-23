{ config, pkgs, ... }:
let
  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "chromium";
    };

    systemPackages = import ./environment/systemPackages.nix { inherit config pkgs; };
  };
in
  environment
