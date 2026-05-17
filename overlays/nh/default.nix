final: prev: {
  nh = prev.nh.overrideAttrs (oldAttrs: {
    version = "master";
    src = prev.fetchFromGitHub {
      owner = "nix-community";
      repo = "nh";
      rev = "247d26d2058eda0ca26315cac8cb415ea599927f";
      hash = "sha256-B14CmTmyokfvM/ADMTyMpaH2Ip8Gtyc35pLpocVf6X4=";
    };
    cargoHash = "";
  });
}
