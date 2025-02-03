{
  stdenv,
  lib,
}: let
  nvim = ./nvim;
in
  stdenv.mkDerivation {
    pname = "cloudglides-nvim-config";
    version = "2.5.0";

    buildCommand = ''
      mkdir -p $out
      cp -r ${nvim}/* "$out/"
    '';

    meta = with lib; {
      platforms = platforms.all;
      license = licenses.gpl3;
    };
  }
