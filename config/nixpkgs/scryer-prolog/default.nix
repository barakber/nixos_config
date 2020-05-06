{ pkgs }:
with pkgs;

rustPlatform.buildRustPackage rec {
  name = "scryer-prolog";
  pname = "scryer-prolog";

  src = fetchFromGitHub {
    owner = "mthom";
    repo = pname;
    rev = "c130b3a92ebf487f75eac247acddb1f233aa515a";
    sha256 = "0yydpzg7l9jyaqwkhw64s5xg6bp6slgqhkq8zq6xjgvri0d1incp";
  };

  cargoSha256 = "1djj4sibiq6n8kpxcnsv1q5ypswb4384q7nrc2wnsycagzg52s1n";

  buildInputs = [
    m4
  ];

  preFixup = ''
  '';

  meta = with stdenv.lib; {
  };
}
