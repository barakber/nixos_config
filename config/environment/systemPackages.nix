{ config, pkgs, ... }:
let
  cli = with pkgs; [
    git
    killall
    wget
    autojump
    brightnessctl
    jq
    csvkit
    html-xml-utils
    ripgrep
    exa
    poppler_utils

    imgcat
    imagemagick
    ffmpeg

    awscli
  ];

  textual = with pkgs; [
    typespeed
    ranger
    tmux
    htop
    lnav
    neovim'
    lynx'
  ];

  visual = with pkgs; [
    zathura
    feh
    mplayer
    gimp
    inkscape
    vokoscreen
    shutter
    libreoffice
    chromium
    baobab
  ];

  im = with pkgs; [
    skype
    zoom-us
    citrix_workspace
  ];

  programming = with pkgs; [
    nix-prefetch-git
    cabal2nix
    gnumake
    nodejs
    jdk
    mercury
    terraform
    terragrunt
    coq
    (haskell.packages.ghc864.ghcWithPackages (ps: with ps; [Agda]))
    swiProlog
  ];

  music = with pkgs; [
    pavucontrol
    qjackctl
    supercollider
    (haskell.packages.ghc864.ghcWithPackages (ps: with ps; [tidal]))
  ];

  other = with pkgs; [
    cacert
    iana-etc
    haskellPackages.xmobar
  ];

  systemPackages = cli ++ textual ++ visual ++ im ++ programming ++ music ++ other;
in
  systemPackages

