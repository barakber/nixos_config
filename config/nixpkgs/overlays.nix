{ config, pkgs, ... }:
let
  overlays = [
    ( self: super:
      { fzf = super.fzf.overrideAttrs (oldAttrs: {
          postInstall = oldAttrs.postInstall + ''
             mkdir -p $out/shell
             cp -r $out/share/fzf/* $out/shell/
           '';
        });

        awscli  = import ./awscli/default.nix { inherit pkgs; };
        amazon-ecs-cli'  = import ./ecscli/default.nix { inherit pkgs; };
        neovim'  = import ./neovim/default.nix { inherit pkgs; };
        ranger = import ./ranger/default.nix { inherit pkgs; };
        lynx'  = import ./lynx/default.nix { inherit pkgs; };
        mercury = import ./mercury.nix { inherit config pkgs; };
        swiProlog = import ./swipl/default.nix { inherit pkgs; };
      }
      )
  ];
in
  overlays
