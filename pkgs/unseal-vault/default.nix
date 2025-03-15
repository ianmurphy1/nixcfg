{
  stdenv,
  lib,
  makeWrapper,
  curl,
  coreutils,
}:
let
  runtimeDeps = [
    curl
    coreutils
  ];
in
stdenv.mkDerivation {
  pname = "unseal-vault";
  version = "0.1.0";
  src = ./.;
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -D -m 0755 script.sh $out/bin/unseal-vault

    # Needs shuf and curl so add to runtimeDeps
    wrapProgram $out/bin/unseal-vault \
      --prefix PATH : ${lib.makeBinPath runtimeDeps}
  '';

  meta = with lib; {
    description = "Program to unseal vault";
    license = licenses.mit;
    platforms = platforms.x86_64;
  };
}
