{ config, pkgs, ... }:
let
  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "chromium";
      FZF_DEFAULT_OPTS = "--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'";
    };

    systemPackages = import ./environment/systemPackages.nix { inherit config pkgs; };
  };
in
  environment
