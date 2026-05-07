{
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "randpass";
  version = "0.0.1";

  src = fetchGit {
    url = "git@github.com:ianmurphy1/randpass.git";
    ref = "main";
    rev = "491c1e0d7bc0402e856c4a0d0f073a0f0659e94c";
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
