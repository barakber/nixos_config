{ config, pkgs, ... }:
let
  #"dill" = pkgs.python37.pkgs.buildPythonPackage rec {
	#name = "dill";
	#src = pkgs.fetchurl {
	  #url = "https://files.pythonhosted.org/packages/c7/11/345f3173809cea7f1a193bfbf02403fff250a3360e0e118a1630985e547d/dill-0.3.1.1.tar.gz";
	  #sha256 = "42d8ef819367516592a825746a18073ced42ca169ab1f5f4044134703e7a049c";
	#};
	#buildDepends = with pkgs; [
	#];
	#propagatedBuildInputs = with pkgs.python37.pkgs; [
	#];
	#doCheck = false;
  #};

  #"marshmallow" = pkgs.python37.pkgs.buildPythonPackage rec {
	#name = "marshmallow";
	#src = pkgs.fetchurl {
	  #url = "https://files.pythonhosted.org/packages/a8/74/5aa84008ddc6e8fee93d961a9f04a745a349ad197d95ab89723c097b330d/marshmallow-3.5.1.tar.gz";
	  #sha256 = "90854221bbb1498d003a0c3cc9d8390259137551917961c8b5258c64026b2f85";
	#};
	#buildDepends = with pkgs; [
	#];
	#propagatedBuildInputs = with pkgs.python37.pkgs; [
	#];
	#doCheck = false;
  #};

  #"marshmallow-polyfield" = pkgs.python37.pkgs.buildPythonPackage rec {
	#name = "marshmallow-polyfield";
	#src = pkgs.fetchurl {
	  #url = "https://files.pythonhosted.org/packages/0c/7e/ceb805d05cd03709b8de122b4ac1e736c4eb91d05281ad2a2bcb484accef/marshmallow-polyfield-5.9.tar.gz";
	  #sha256 = "448f4b1ac5cbd671c0fb8a5452e99da7c0e8be924dd2cda2a21ee59457a4748f";
	#};
	#buildDepends = with pkgs; [
	#];
	#propagatedBuildInputs = with pkgs.python37.pkgs; [
		#marshmallow
	#];
	#doCheck = false;
  #};

  #"qiskit-terra" = pkgs.python37.pkgs.buildPythonPackage rec {
	#name = "qiskit-terra";
	#src = pkgs.fetchurl {
	  #url = "https://files.pythonhosted.org/packages/00/52/0088b3cb93f2c63810312952182c5fdc7ab9cd477b1b2d6e3fa2455b7ee0/qiskit-terra-0.12.0.tar.gz";
	  #sha256 = "c4b35b3a79fe0b5f25821a855c5c2dc997fc3f269954865d69a8d1ae3c9ba347";
	#};
	#buildDepends = with pkgs; [
	#];
	#propagatedBuildInputs = with pkgs.python37.pkgs; [
		#cython
		#scipy
		#marshmallow
		#marshmallow-polyfield
		#ply
		#jsonschema
		#sympy
		#psutil
		#networkx
		#dill
	#];
	#doCheck = false;
  #};

  #"qiskit-ignis" = pkgs.python37.pkgs.buildPythonPackage rec {
	#name = "qiskit-ignis";
	#src = pkgs.fetchurl {
	  #url = "https://files.pythonhosted.org/packages/70/eb/0b3810d4dc1607507b843e75f367682d234f5e466cb0ca0b6bfb87b9b2f0/qiskit-ignis-0.2.0.tar.gz";
	  #sha256 = "c6bb3c36ede3d625a9d094fddd186d96fb0c532fb507b3f9dbc3bb361f74c38d";
	#};
	#buildDepends = with pkgs; [
	#];
	#propagatedBuildInputs = with pkgs.python37.pkgs; [
		#scipy
		#qiskit-terra
	#];
	#doCheck = false;
  #};

  #"qiskit-aer" = pkgs.python37.pkgs.buildPythonPackage rec {
	#name = "qiskit-aer";
	#src = pkgs.fetchurl {
	  #url = "https://files.pythonhosted.org/packages/71/f1/acdceccf068dde1ca59f0a2682ca7916c7b90d55f6e99ab62dffa016c6c5/qiskit_aer-0.4.1-cp37-cp37m-manylinux2010_x86_64.whl";
	  #sha256 = "6d95c2a5b3b2da9f0bae7410805095368f54c8b002cf089f3069efcf48129a26";
	##src = pkgs.fetchgit {
	  ##url = "https://github.com/Qiskit/qiskit-aer";
	  ##rev = "1460009f053f77adb742f1bad0dfed976370e1e7";
	  ##sha256 = "1jywzp2pwyxq1yjh09nqjwhp6aryn0v5kk4bx7afhrrjmvz8axh5";
	#};
	#buildDepends = with pkgs; [
	#];
	#propagatedBuildInputs = with pkgs.python37.pkgs; [
		#qiskit-terra
		#scikit-build
		#pybind11
		#numpy
		#cython
	#];
	#doCheck = false;
  #};

  #"qiskit" = pkgs.python37.pkgs.buildPythonPackage rec {
	#name = "qiskit";
	#src = pkgs.fetchurl {
	  #url = "https://files.pythonhosted.org/packages/31/03/9a823e07f7b15ff8f474f09e30b756eb861ed0251f77d225ebef3aa13094/qiskit-0.16.2.tar.gz";
	  #sha256 = "69852d6eeea1d368cb5043822349f5818b9b7899fa1b44e549ca654286ce3671";
	#};
	#buildDepends = with pkgs; [
		#cmake
	#];
	#propagatedBuildInputs = with pkgs.python37.pkgs; [
		#qiskit-ignis
		#qiskit-aer
	#];
	#doCheck = false;
  #};

  "PyMonad" = pkgs.python37.pkgs.buildPythonPackage rec {
    name = "PyMonad";
    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/6b/c5/f1affc732c35903266b164c26dea2fda56c8a2eb498d18bcd38349c66f5b/PyMonad-1.3.tar.gz";
      sha256 = "a3a2621bb2175d4e1c710c52338991a63f22160640b1f34571a6f90f9a689764";
    };
    buildDepends = with pkgs; [
    ];
    propagatedBuildInputs = with pkgs.python37.pkgs; [
    ];
    doCheck = false;
  };

  python' = pkgs.python37.withPackages (ps: with ps; [
    numpy
    pandas
    scikitlearn
    pyarrow
    PyMonad
    ipython
    virtualenv
    joblib
    #qiskit
  ]);
in
  python'



