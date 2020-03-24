{ pkgs }:
with pkgs;
let
  awscli =stdenv.mkDerivation {
    name = "awscli";
    src = fetchzip {
      url = https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip;
      sha256 = "1pqvqhxbikqnji7nazvaqnk2czlmr3kvs1zyl13w96ym4if3np1v";
    };
    propagatedBuildInputs = [
    ];
    installPhase = ''
      mkdir -p $out/bin
      ./install -i $out -b $out/bin
    '';
  };
in buildFHSUserEnv {
  name = "awscli";
  targetPkgs = pkgs: with pkgs; [
    awscli
    groff
  ];
  profile = ''
    export C_INCLUDE_PATH=/usr/include:$C_INCLUDE_PATH
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${awscli}/v2/dist
  '';
}
