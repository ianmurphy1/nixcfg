{
  stdenv,
  lib,
  makeWrapper,
  coreutils,
  awscli2,
  ssm-session-manager-plugin,
  openssh,
}:
let
  runtimeDeps = [
    coreutils
    awscli2
    ssm-session-manager-plugin
    openssh
  ];
in
stdenv.mkDerivation {
  pname = "ssh-ssm";
  version = "0.1.0";
  src = ./.;
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -D -m 0755 script.sh $out/bin/ssh-ssm

    wrapProgram $out/bin/ssh-ssm \
      --prefix PATH : ${lib.makeBinPath runtimeDeps}
  '';

  meta = with lib; {
    description = "Program to use ssh over ssm";
    license = licenses.mit;
    platforms = platforms.x86_64;
  };
}

