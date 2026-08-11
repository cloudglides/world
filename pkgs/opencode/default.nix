{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  ripgrep,
  bun,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "cloudglides-opencode";
  version = "1.18.16";

  src = fetchurl {
    url = "https://github.com/anomalyco/opencode/releases/download/v${finalAttrs.version}/opencode-linux-x64.tar.gz";
    hash = "sha256-KG4HNV3wZzjBkFlVvhW3+8EKexLZMd6TlKb3WXJGdQs=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    bun
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -Dm755 opencode $out/bin/opencode
    runHook postInstall
  '';

  meta = with lib; {
    description = "The open source coding agent";
    homepage = "https://opencode.ai";
    license = licenses.mit;
    platforms = ["x86_64-linux"];
    mainProgram = "opencode";
  };
})
