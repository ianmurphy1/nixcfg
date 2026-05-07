{
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "randpass";
  version = "0.0.1";

  src = fetchGit {
    url = "git@github.com:ianmurphy1/randpass.git";
    ref = "main";
    rev = "ca5f86e90f4cabccbc2114d0f98a0bbb28642982";
  };

  cargoHash = "sha256-aL6PO5hXCRWNvl3c8/oOs8BqbQAb82Yf4ziQJcT42Yk=";

  meta = {
    description = "Small cli to generate random passwords";
    homepage = "https://github.com/ianmurphy1/randpass";
    maintainers = [
      "ianm"
    ];
  };

})
