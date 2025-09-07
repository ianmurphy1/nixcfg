# No longer required as fixed in nixpkgs
final: prev: {
  python313Packages = prev.python313Packages // {
    i3ipc = prev.python313Packages.i3ipc.overrideAttrs (old: {
      doCheck = false;
      checkPhase = ''
        echo "Skipping pytest in Nix build"
      '';
      installCheckPhase = ''
        echo "Skipping install checks in Nix build"
      '';
    });
  };
}
