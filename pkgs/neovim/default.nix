{ stdenv, lib }:
stdenv.mkDerivation {
  pname = "cloudglides-nvim";
  version = "2.5.0";
  
  # Use builtins.path for pure evaluation
  src = builtins.path {
    path = ./nvim;
    name = "nvim-config";
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
