{ config, pkgs, ... }:
let
  cli = with pkgs; [
    gitAndTools.git
    delta
    dvc

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
    fd
    tealdeer
    procs
    go-jira

    imgcat
    imagemagick
    ffmpeg

  ];

  devops = with pkgs; [
    gnutls
    docker-compose
    azure-cli
    #awscli
    #amazon-ecs-cli
    terraform
    terragrunt
    kubectl
  ];

  textual = with pkgs; [
    typespeed
    ranger
    tmux
    htop
    lnav
    neovim
    lynx
  ];

  visual = with pkgs; [
    zathura
    feh
    mplayer
    gimp
    meld
    inkscape
    vokoscreen
    shutter
    libreoffice
    chromium
    baobab
    keynav
    xdotool
    onboard
  ];

  im = with pkgs; [
    zoom-us
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
    #mercury
    #coq
    swiProlog
    #scryer-prolog
    cue

    haskell'
    python'
  ];

  music = with pkgs; [
    #pavucontrol
    #qjackctl
    #supercollider
  ];

  other = with pkgs; [
    cacert
    iana-etc
    haskellPackages.xmobar
    xxHash
    texlive.combined.scheme-full
  ];

  systemPackages = cli ++ textual ++ visual ++ im ++ devops ++ programming ++ music ++ other;
in
  systemPackages

