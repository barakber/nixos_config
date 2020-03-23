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

        mercury = import ./mercury.nix { inherit config pkgs; };
      }
      )
  ];
in
  overlays
