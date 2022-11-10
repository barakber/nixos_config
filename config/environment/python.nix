{ config, pkgs, ... }:
let
  python' = pkgs.python310.withPackages (ps: with ps; [
    numpy
    pandas
    scikitlearn
  ]);
in
  python'



