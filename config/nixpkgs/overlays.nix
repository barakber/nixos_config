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

        awscli          = import ./awscli/default.nix { inherit pkgs; };
        amazon-ecs-cli' = import ./ecscli/default.nix { inherit pkgs; };
        neovim'         = import ./neovim/default.nix { inherit pkgs; };
        ranger          = import ./ranger/default.nix { inherit pkgs; };
        lynx'           = import ./lynx/default.nix   { inherit pkgs; };
        mercury         = import ./mercury.nix        { inherit config pkgs; };
        swiProlog       = import ./swipl/default.nix  { inherit pkgs; };
        weechat'        = import ./weechat/default.nix { inherit pkgs; };
        #quartus-prime   = pkgs.callPackage ./quartus-prime/default.nix {};
      }
      )
  ];
in
  overlays
