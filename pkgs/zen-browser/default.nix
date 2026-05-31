{
  stdenv,
  lib,
  ...
}:
stdenv.mkDerivation rec {
  pname = "unseal-vault-bin";
  version = "1.20.1b";

  src = fetchTarball {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.xz";
    sha256 = "0qly1k025jf3lmpqghhpwhwc44d2bgj03fgh6xzk4ml3qfk990wy";
  };

  installPhase = ''
    set -x
    runHook preInstall


    ls -la .



    runHook postInstall
  '';


  meta = with lib; {
    description = "Zen Browser";
    license = licenses.mit;
    platforms = platforms.x86_64;
  };
}
