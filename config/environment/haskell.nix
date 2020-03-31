{ config, pkgs, ... }:
let
  haskell' = pkgs.haskell.packages.ghc864.ghcWithPackages (ps: with ps; [
    Agda
    tidal
  ]);
in
  haskell'

