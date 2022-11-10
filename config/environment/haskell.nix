{ config, pkgs, ... }:
let
  haskell' = pkgs.haskell.packages.ghc922.ghcWithPackages (ps: with ps; [
  ]);
in
  haskell'

