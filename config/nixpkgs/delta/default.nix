{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "delta";
  version = "0.0.17";

  src = fetchFromGitHub {
    owner = "dandavison";
    repo = pname;
    rev = version;
    sha256 = "1j01h60snciqp4psyxf67j3gbmi02c1baprsg9frzjacawbx8cz7";
  };

  cargoSha256 = "18iw6r1pzr9gna9nj53n1cz9g07x6fg98dr3wjvk3bkvvx26pdsh";

  meta = with lib; {
    homepage = "https://github.com/dandavison/delta";
    description = "A syntax-highlighting pager for git";
    changelog = "https://github.com/dandavison/delta/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ marsam ma27 ];
  };
}
