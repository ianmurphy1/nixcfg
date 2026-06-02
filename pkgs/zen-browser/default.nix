{
  lib,
  stdenv,
  config,
  wrapGAppsHook3,
  autoPatchelfHook,
  patchelfUnstable,
  adwaita-icon-theme,
  dbus-glib,
  libXtst,
  curl,
  gtk3,
  alsa-lib,
  libva,
  pciutils,
  pipewire,
  writeText,
  ...
}:
let
  policies = {
    DisableAppUpdate = true;
  } // config.zen.policies or { };

  policiesJson = writeText "firefox-policies.json" (builtins.toJSON { inherit policies; });
in
stdenv.mkDerivation rec {
  pname = "unseal-vault-bin";
  version = "1.20.1b";

  src = fetchTarball {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.xz";
    sha256 = "0qly1k025jf3lmpqghhpwhwc44d2bgj03fgh6xzk4ml3qfk990wy";
  };

  nativeBuildInputs = [
    wrapGAppsHook3
    autoPatchelfHook
    patchelfUnstable
  ];

  buildInputs = [
    gtk3
    alsa-lib
    adwaita-icon-theme
    dbus-glib
    libXtst
  ];

  runtimeDependencies = [
    curl
    libva.out
    pciutils
  ];

  appendRunpaths = [
    "${pipewire}/lib"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$prefix/lib/zen-${version}"
    cp -r * "$prefix/lib/zen-${version}"

    mkdir -p "$out/bin"
    ln -s "$prefix/lib/zen-${version}/zen" "$out/bin/zen"

    mkdir -p "$out/lib/zen-${version}/distribution"
    ln -s ${policiesJson} "$out/lib/zen-${version}/distribution/policies.json"

    runHook postInstall
  '';

  patchelfFlags = [ "--no-clobber-old-sections" ];


  meta = with lib; {
    mainProgram = "zen";
    description = "Zen Browser";
    license = licenses.mit;
    platforms = platforms.x86_64;
  };
}
