{ pkgs }:
with pkgs;
python310Packages.buildPythonApplication rec {
  name = "ranger";

  meta = {
    description = "File manager with minimalistic curses interface";
    homepage = http://ranger.nongnu.org/;
    #license = stdenv.lib.licenses.gpl3;
    #platforms = stdenv.lib.platforms.unix;
  };

  src = fetchgit {
    url = "https://github.com/ranger/ranger";
    rev = "081e73152a9391211770fab56676d7d974413ae6";
    sha256 = "0xsz8nl1k8p1hxc3p6p4x85wn2kwkj1hi5xsiapbfkbxhhg1kq78";
  };

  checkInputs = with pythonPackages; [ pytest ];
  propagatedBuildInputs = [ file
                            w3m
                            highlight
                            bat
                            atool
                            mediainfo
                            odt2txt
                            xsv
                            jq
                            binutils
                            hexd
                            git
                            poppler_utils
                            (python310.withPackages (ps: with ps; [jupytext pandoc setuptools]))
                          ];

  checkPhase = ''
    py.test tests
  '';

  preConfigure = ''
    cp ${scope} ranger/data/scope.sh
    substituteInPlace ranger/data/scope.sh \
      --replace "/bin/echo" "echo"

    cp ${rifle} ranger/config/rifle.conf

    for i in ranger/config/rc.conf doc/config/rc.conf ; do
      substituteInPlace $i --replace /usr/share $out/share
    done

    substituteInPlace ranger/config/rc.conf \
      --replace "set preview_script ~/.config/ranger/scope.sh" "set preview_script $out/share/doc/ranger/config/scope.sh"
    substituteInPlace ranger/ext/img_display.py \
      --replace /usr/lib/w3m ${w3m}/libexec/w3m
    # give image previews out of the box when building with w3m
    substituteInPlace ranger/config/rc.conf \
      --replace "set preview_images false" "set preview_images true" \
  '';

  scope = ./scope.sh;
  rifle = ./rifle.conf;
}
