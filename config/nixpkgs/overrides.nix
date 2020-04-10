{ config, pkgs, ... }:
let
  nixpkgsTarGz = builtins.fetchTarball
    { name   = "20.03-beta";
      url    = "https://github.com/NixOS/nixpkgs/archive/20.03-beta.tar.gz";
      sha256 = "sha256:04g53i02hrdfa6kcla5h1q3j50mx39fchva7z7l32pk699nla4hi";
    };
  nixpkgs = import nixpkgsTarGz
    { config.allowUnfree = true;
    };

  packageOverrides = pkgs: {
    awscli          = import ./awscli/default.nix { inherit pkgs; };
    amazon-ecs-cli  = import ./ecscli/default.nix { inherit pkgs; };
    neovim          = import ./neovim/default.nix { inherit pkgs; };
    ranger          = import ./ranger/default.nix { inherit pkgs; };
    lynx            = import ./lynx/default.nix   { inherit pkgs; };
    mercury         = import ./mercury.nix        { inherit config pkgs; };
    swiProlog       = import ./swipl/default.nix  { inherit pkgs; };
    weechat         = import ./weechat/default.nix { inherit pkgs; };
    rxvt_unicode_with-plugins = nixpkgs.rxvt_unicode_with-plugins;
    #quartus-prime   = pkgs.callPackage ./quartus-prime/default.nix {};
  };
in
  packageOverrides
