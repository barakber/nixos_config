{ config, pkgs, ... }:
let
  zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    interactiveShellInit = ''
      export FZF_BASE=${pkgs.fzf}
    '';
    promptInit = ''
      PROMPT='[%D{%f/%m/%y}|%@] %(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '
    '';
    shellAliases = {
      ls = "exa";
      vim = "nvim";
      identify = "python ~/Downloads/identify.py";
      figure   = "~/figure";
      simulate = "faker -r 1000 -s=\" \" ";
      generate = "faker -r 1000 -s=\" \" ";
    };
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "man"
                  "git"
                  "git-prompt"
                  "sudo"
                  "terraform"
                  "kubectl"
                  "docker"
                  "timer"
                  "fzf"
                  "autojump"
                ];
    };
  };
in
  zsh
