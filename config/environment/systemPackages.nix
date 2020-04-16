{ config, pkgs, ... }:
let
  cli = with pkgs; [
    gitAndTools.git
    delta

    killall
    wget
    autojump
    brightnessctl
    jq
    csvkit
    html-xml-utils
    poppler_utils
    hexd
    ripgrep
    exa
    bat
    tealdeer
    procs

    imgcat
    imagemagick
    ffmpeg

  ];

  devops = with pkgs; [
    docker-compose
    nixops
    azure-cli
    awscli
    amazon-ecs-cli
    terraform
    terragrunt
  ];

  textual = with pkgs; [
    typespeed
    ranger
    tmux
    htop
    lnav
    gcalcli
    neovim
    lynx
    weechat
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

    #quartus-prime
  ];

  im = with pkgs; [
    skype
    zoom-us
    citrix_workspace
  ];

  haskell' = import ./haskell.nix { inherit config pkgs; };

  python' = import ./python.nix { inherit config pkgs; };

  programming = with pkgs; [
    nix-prefetch-git
    cabal2nix
    gnumake
    cmake
    nodejs
    jdk
    mercury
    coq
    swiProlog
    cue

    haskell'
    python'
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
    xxHash
  ];

  systemPackages = cli ++ textual ++ visual ++ im ++ devops ++ programming ++ music ++ other;
in
  systemPackages

