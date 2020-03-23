{ config, pkgs, ... }:
let
  cli = with pkgs; [
    typespeed
    tmux
    htop
    git
    killall
    wget
    vim
    autojump
    brightnessctl
    lnav
    csvkit

    imgcat
    imagemagick
    ffmpeg
  ];

  visual = with pkgs; [
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
  ];

  other = with pkgs; [
    cacert
    iana-etc
    haskellPackages.xmobar
  ];

  systemPackages = cli ++ visual ++ im ++ programming ++ other;
in
  systemPackages

