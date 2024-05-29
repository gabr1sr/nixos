{ lib, pkgs, fetchzip, unzip, ... }:
let
  version = "1.0";
  pname = "feather-icon-font";
in pkgs.stdenv.mkDerivation {
  name = "${pname}-${version}";

  src = fetchzip {
    url = "https://github.com/dustinlyons/feather-font/archive/refs/tags/${version}.zip";
    sha256 = "sha256-Zsz8/qn7XAG6BVp4XdqooEqioFRV7bLH0bQkHZvFbsg=";
  };

  buildInputs = [ unzip ];
  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src/feather.ttf $out/share/fonts/truetype/
  '';

  meta = with lib; {
    homepage = "https://www.feathericons.com/";
    description = "Set of font icons from the open source collection Feather Icons";
    license = licenses.mit;
  };
}