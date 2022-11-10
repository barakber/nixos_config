{ config, pkgs, ... }:
let
  nixpkgsTarGz = builtins.fetchTarball
    { name   = "20.03";
      url    = "https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz";
      sha256 = "0182ys095dfx02vl2a20j1hz92dx3mfgz2a6fhn31bqlp1wa8hlq";
    };
  nixpkgs = import nixpkgsTarGz
    { config.allowUnfree = true;
    };

  packageOverrides = pkgs: {
    awscli          = import ./awscli/default.nix { inherit pkgs; };
    neovim          = import ./neovim/default.nix { inherit pkgs; };
#    ranger          = import ./ranger/default.nix { inherit pkgs; };
    lynx            = import ./lynx/default.nix   { inherit pkgs; };
#    swiProlog       = import ./swipl/default.nix  { inherit pkgs; };
    #scryer-prolog   = import ./scryer-prolog/default.nix { inherit pkgs; };
    #delta           = with pkgs; import ./delta/default.nix { inherit lib fetchFromGitHub rustPlatform; };
    dvc = nixpkgs.dvc;
  };
in
  packageOverrides
