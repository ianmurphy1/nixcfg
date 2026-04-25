{ lib }:
_: pyprev: {
  cli-helpers =
    assert lib.assertMsg (pyprev.cli-helpers.version == "2.10.0")
      "Overlay nix/overlays/cli-helpers.nix is no longer needed: cli-helpers is now ${pyprev.cli-helpers.version}. Delete this overlay.";
    pyprev.cli-helpers.overridePythonAttrs (old: {
      disabledTests = (old.disabledTests or [ ]) ++ [
        "test_style_output"
        "test_style_output_with_newlines"
        "test_style_output_custom_tokens"
      ];
    });
}
