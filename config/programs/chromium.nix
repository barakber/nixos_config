{ config, pkgs, ... }:
let
  chromium = {
    enable = true;
    extensions = [ "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
                 ];
  };
in
  chromium
