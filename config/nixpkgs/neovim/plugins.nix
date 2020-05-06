{ pkgs, vimUtils, fetchgit }:
{
  fzf = vimUtils.buildVimPluginFrom2Nix {
    name = "fzf.vim";
    src = fetchgit {
      url = "https://github.com/junegunn/fzf.vim";
      rev = "f86ef1bce602713fe0b5b68f4bdca8c6943ecb59";
      sha256 = "0h3mlc4lvnlzg7pfrr09vrfn93lglzfp5ca6bl4jhsi63xw7x3ad";
    };
  };

  coquille = vimUtils.buildVimPluginFrom2Nix {
    name = "coquille";
    src = fetchgit {
      url = "https://github.com/kriw/coquille";
      rev = "e1611a6ec3c17ca8a8b7ec47d9810bfb15d00576";
      sha256 = "069hfhwfr4a460hx9x5i4vfxlbacw1vwv6jd93v6dvadpdylr5x5";
    };
  };

  tlaplus = vimUtils.buildVimPluginFrom2Nix {
    name = "tla";
    src = fetchgit {
      url = "https://github.com/hwayne/tla.vim";
      rev = "0d6d453a401542ce1db247c6fd139ac99b8a5add";
      sha256 = "1bfxnvx3g5679jan7v5prh7zk0f77m81g8c9ngq75nxdn20ihl7l";
    };
    dependencies = [];
  };

  minimap = vimUtils.buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "minimap";
    src = fetchgit {
      url = "https://github.com/severin-lemaignan/vim-minimap";
      rev = "65ab020961c760bc56a771ffae541fe669536f50";
      sha256 = "02sxxcancl0pwrqa208rmhva2scg6j87m8wlkam6ddbyqpwv275g";
    };
    dependencies = [];
  };

  vim-ranger = vimUtils.buildVimPluginFrom2Nix {
    name = "vim-ranger";
    src = fetchgit {
      url = "https://github.com/francoiscabrol/ranger.vim";
      rev = "e8963d5b1ea0d42f1706bc5442290d68b0f731bd";
      sha256 = "1w2rd6rcfh59i423vbdxd6diyylddjx2pk0xbaahk6p409qjqyk1";
    };
    dependencies = [];
  };

  vim-bookmarks = vimUtils.buildVimPluginFrom2Nix {
    name = "vim-bookmarks";
    src = fetchgit {
      url = "https://github.com/MattesGroeger/vim-bookmarks";
      rev = "3adeae10639edcba29ea80dafa1c58cf545cb80e";
      sha256 = "1ikgs5cnqs9bhr8fqan8hg14px1j331l0b51yhnx00rmj4lr44bm";
    };
    dependencies = [];
  };

  vim-ripgrep = vimUtils.buildVimPluginFrom2Nix {
    name = "vim-ripgrep";
    src = fetchgit {
      url = "https://github.com/jremmen/vim-ripgrep";
      rev = "ec87af6b69387abb3c4449ce8c4040d2d00d745e";
      sha256 = "1by56rflr0bmnjvcvaa9r228zyrmxwfkzkclxvdfscm7l7n7jnmh";
    };
    dependencies = [];
  };

  repl-vim = vimUtils.buildVimPluginFrom2Nix {
    name = "repl-vim";
    src = fetchgit {
      url = "https://github.com/ujihisa/repl.vim";
      rev = "d71c5f06da9b15d78adc41fb8f96c833b70bb4fb";
      sha256 = "1fly5axnhsywxn56xcvy2ba94iybvg90gi32ly5k7pdvpvj9pgc3";
    };
    dependencies = [];
  };

  git-messenger = vimUtils.buildVimPluginFrom2Nix {
    name = "git-messenger";
    src = fetchgit {
      url = "https://github.com/rhysd/git-messenger.vim";
      rev = "4b436f8b1c9b04b7424a732cecf8b6de81e7bfd9";
      sha256 = "0mp85kyiwqhqgbc7znv5xgi0xl23zjbbq7agv0h9m2214vbra1rp";
    };
    dependencies = [];
  };

  vim-pandoc-markdown-preview = vimUtils.buildVimPluginFrom2Nix {
    name = "vim-pandoc-markdown-preview";
    src = fetchgit {
      url = "https://github.com/conornewton/vim-pandoc-markdown-preview";
      rev = "d2f8561ffccff0a670be0fbe06e76d39919855ca";
      sha256 = "0zmng7zp9vv5ds5js42ybvs0vzwspsc2nk2q7hfya0l09hnqhwip";
    };
    dependencies = [];
  };

  rainbow_csv = vimUtils.buildVimPluginFrom2Nix {
    name = "rainbow_csv";
    src = fetchgit {
      url = "https://github.com/mechatroner/rainbow_csv";
      rev = "9bfe572bdb7303424afaaef656c1502cd634bceb";
      sha256 = "1ldybgn10p4gq4cbbjrd1r6wslz6l6vzhz33mm0nhbw27w9dx7ww";
    };
    dependencies = [];
  };

  LanguageClient-neovim = vimUtils.buildVimPluginFrom2Nix {
    name = "LanguageClient-neovim";
    src = fetchgit {
      url = "https://github.com/autozimu/LanguageClient-neovim";
      rev = "109f77ff32c60fb28d406e1801d6b4c2828f7280";
      sha256 = "1d87gxhah7iw28cily7r9dh2n2pa98lyz4prywmx35gm0gqz6kgn";
    };
    dependencies = [];
  };

  idris-vim = vimUtils.buildVimPluginFrom2Nix {
    name = "idris-vim";
    src = fetchgit {
      url = "https://github.com/idris-hackers/idris-vim";
      rev = "109f77ff32c60fb28d406e1801d6b4c2828f7280";
    };
    dependencies = [];
  };

  mercury-vim = vimUtils.buildVimPluginFrom2Nix {
    name = "mercury-vim";
    src = fetchgit {
      url = "https://github.com/stewy33/mercury-vim";
      rev = "8749bec220c684d644202d0fef3246ad0c73d5c4";
      sha256 = "168d8n78jk6992chag40hqgwxwy8l12nyjq5jiigix73bzz7z3x3";
    };
    dependencies = [];
  };

  vim-numbertoggle = vimUtils.buildVimPluginFrom2Nix {
    name = "vim-numbertoggle";
    src = fetchgit {
      url = "https://github.com/jeffkreeftmeijer/vim-numbertoggle";
      rev = "cfaecb9e22b45373bb4940010ce63a89073f6d8b";
      sha256 = "1rrmvv7ali50rpbih1s0fj00a3hjspwinx2y6nhwac7bjsnqqdwi";
    };
    dependencies = [];
  };

  vim-tidal = vimUtils.buildVimPluginFrom2Nix {
    name = "vim-tidal";
    src = fetchgit {
      url = "https://github.com/tidalcycles/vim-tidal";
      rev = "5606b8146b8ae2efbaa14b30207a4e0b70e5826c";
      sha256 = "1x64d8jdlcw16pcp19xb0krd1jfqhva4xsxif8xc11pyj52sxxlh";
    };
    postInstall = ''
      sed -i "s|  split term://tidal|  split term://$out/share/vim-plugins/vim-tidal/bin/tidal|g" $out/share/vim-plugins/vim-tidal/plugin/tidal.vim
      cat plugin/tidal.vim | grep "term:"
    '';
    dependencies = [];
  };


  vimpyter = vimUtils.buildVimPluginFrom2Nix {
    name = "vimpyter";
    src = fetchgit {
      url = "https://github.com/szymonmaszke/vimpyter";
      rev = "25a0acbe81d445ece0df78cb23e2d5011df1b63a";
      sha256 = "0kwf8ls5nar8wa36lfrbm3ysryim2pcz9ywv18rjqfp7wacz683c";
    };
    postInstall = ''
    '';
    dependencies = [];
  };
}
