let
  pkgs = import <nixpkgs> { };
in
  pkgs.callPackage ./ds9.nix {}
