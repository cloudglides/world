{
  stdenv,
  lib,
}:
stdenv.mkDerivation {
  pname = "cloudglides-ghostty";
  version = "2.5.0";

  src = builtins.path {
    path = ./ghostty;
    name = "ghostty-config";
  };

  installPhase = ''
    mkdir -p $out
    cp -r $src/* "$out/"
  '';

  meta = with lib; {
    platforms = platforms.all;
    license = licenses.gpl3;
  };
}
