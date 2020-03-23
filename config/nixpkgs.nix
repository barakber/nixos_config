{ config, pkgs, ... }:
let
  nixpkgs = with pkgs; {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };

    overlays = import ./nixpkgs/overlays.nix { inherit config pkgs; };
  };
in
  nixpkgs

