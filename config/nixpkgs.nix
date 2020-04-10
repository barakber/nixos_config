{ config, pkgs, ... }:
let
  nixpkgs = with pkgs; {
    config = {
      allowUnfree = true;
      allowBroken = true;
      packageOverrides = import ./nixpkgs/overrides.nix { inherit config pkgs; };
    };

    overlays = import ./nixpkgs/overlays.nix { inherit config pkgs; };
  };
in
  nixpkgs

