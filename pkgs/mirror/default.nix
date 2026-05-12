{
  stdenv,
  lftp,
  lib,
  makeWrapper,
}:
let
  runtimeDeps = [
    lftp
  ];
in
stdenv.mkDerivation {
  pname = "mirror";
  version = "0.1.0";
  src = ./.;
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    install -D -m 0755 script.sh $out/bin/mirror

    wrapProgram $out/bin/mirror \
      --prefix PATH : ${lib.makeBinPath runtimeDeps}
  '';

  meta = with lib; {
    description = "Download from seedbox recursively";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
