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
    swiProlog
  ];

  music = with pkgs; [
    pavucontrol
    qjackctl
    supercollider
  ];

  other = with pkgs; [
    cacert
    iana-etc
    haskellPackages.xmobar
    (haskell.packages.ghc864.ghcWithPackages (ps: with ps; [Agda tidal]))
  ];

  systemPackages = cli ++ textual ++ visual ++ im ++ programming ++ music ++ other;
in
  systemPackages

