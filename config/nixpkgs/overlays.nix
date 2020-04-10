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

        typespeed = super.typespeed.overrideAttrs (oldAttrs: {
          postUnpack = ''
            sed -i "s|start_color|     use_default_colors(); start_color|g" typespeed-0.6.5/src/misc.c
            sed -i "s|COLOR_BLACK|-1|g" typespeed-0.6.5/src/misc.c
           '';
        });
      }
      )
  ];
in
  overlays
