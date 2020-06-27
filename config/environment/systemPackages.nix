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
    nixops
    azure-cli
    awscli
    amazon-ecs-cli
    terraform
    terragrunt
    kubectl
    kubernetes-helm
  ];

  textual = with pkgs; [
    typespeed
    ranger
    tmux
    htop
    lnav
    gcalcli
    neovim
    neovim-remote
    lynx
    weechat
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

    #ds9
    #quartus-prime
  ];

  im = with pkgs; [
    skype
    zoom-us
    #citrix_workspace
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
    #scryer-prolog
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
    texlive.combined.scheme-full
  ];

  systemPackages = cli ++ textual ++ visual ++ im ++ devops ++ programming ++ music ++ other;
in
  systemPackages

