{ stdenv, fetchFromGitHub
, file, which, zip
, autoconf, libtool
, gfortran, perl
, libX11, libXft, zlib, libxml2, libxslt
, openssl_1_0_2
, tcl, tk }:

#, autoconf, automake, libtool

# SAOImageDS9 requires openssl 1.0.x, not 1.1.x.
#
stdenv.mkDerivation rec {

  name = "ds9-${version}";
  version = "8.1b1";

  src = fetchFromGitHub {
    owner = "SAOImageDS9";
    repo = "SAOImageDS9";
    rev = "1eba519fa1da36b081a2a0c4e6fd82fe872d4038";
    sha256 = "009fvr6mjr73np2rg82nykjgq3blwh50ykj2cgq5spwckcnrrarq";
  };

  # try and hack the build
  patches = [
    ./nix-build.patch
  ];

  # It is easiest for me (at the moment) to have the Makefile patch
  # use `which xml2-config` rather than try and do this "properly"
  # (maybe by having the patch add in @foo@ which is then changed in
  # the preConfigure step)
  #
  nativeBuildInputs = [
    file which zip
    autoconf libtool
    gfortran
  ];

  # I have not spent the time to work out whether any of these can
  # go into one of the other *Inputs attributes; that is, I am sticking
  # everything in buildInputs
  #
  buildInputs = [
    libX11 libXft zlib libxml2 libxslt openssl_1_0_2 tcl tk
    perl
  ];

  # I don't understand why it is only funtools/mkconfigure that needs
  # this replacement
  #
  preConfigure = ''
    export TLSFLAGS="--with-ssl-dir=${openssl_1_0_2.dev}"

    substituteInPlace tksao/configure --replace /usr/include/libxml2 ${libxml2.dev}/include/libxml2

    substituteInPlace funtools/mkconfigure --replace /bin/bash $SHELL

  '';
  postConfigure = ''
    TLSFLAGS=
  '';
  configureScript = "unix/configure";
  
  # I think at least one piece of code needs this, so just apply it
  # to everything for now.
  #
  hardeningDisable = [ "format" ];

  installPhase = ''
    echo "*** In install phase"
    mkdir -p $out/bin
    for x in ds9 xpaaccess xpaget xpainfo xpamb xpans xpaset ; do
      echo "*** copying $x"
      cp bin/$x $out/bin
    done

    # only copy over the XPA man pages
    mkdir -p $out/man/man1
    cp man/man1/xpa*1 $out/man/man1
    
  '';

  # I assume that something in the stripping messes up all of
  # DS9's internal paths, since it can not find files within its
  # own file system after the standard fixupPhase, so skip for now.
  #
  dontStrip = true;
  
  # It can build on macOS systems but I haven't tried it.
  #
  meta = {
    description = "Interactive data visualization (focusing on Astronomy)";
    longDescription = ''
    SAOImage DS9 is an astronomical imaging and data visualization
    application. DS9 supports FITS images and binary tables, multiple
    frame buffers, region manipulation, and many scale algorithms and
    colormaps. It provides for easy communication with external
    analysis tasks and is highly configurable and extensible via XPA
    and SAMP.

    DS9 is a stand-alone application. It requires no installation or
    support files. All versions and platforms support a consistent set
    of GUI and functional capabilities.

    DS9 supports advanced features such as 2-D, 3-D and RGB frame
    buffers, mosaic images, tiling, blinking, geometric markers,
    colormap manipulation, scaling, arbitrary zoom, cropping,
    rotation, pan, and a variety of coordinate systems.

    The GUI for DS9 is user configurable. GUI elements such as the
    coordinate display, panner, magnifier, horizontal and vertical
    graphs, button bar, and color bar can be configured via menus or
    the command line.

    The XPA command-line tools are currently included, since they allow
    communicatiob between DS9 and external programs. This may change.
    '';

    homepage = http://ds9.si.edu/site/Home.html;
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.linux;
  };
}
