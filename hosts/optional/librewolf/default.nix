{ lib, config, pkgs, ... }:
let
  hostName = config.networking.hostName;
  scales = {
    nixos = "1.25";
    nixvirt = "1.25";
    galaxy = "1.15";
    legion = "1.25";
    titan = "1.0";
  };
in
{
  programs.firefox = {
    package = pkgs.unstable.librewolf;
    languagePacks = [
      "en-GB"
    ];
    enable = true;
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = false;
      DisableFirefoxSuggest = true;
      DisableFormHistory = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      ExtensionSettings = with builtins;
        let extension = shortId: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "normal_installed";
          };
        };
        in listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
          (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
        ] // {"*".installation_mode = "blocked";};
    };
    preferences = {
      "cookiebanners.service.mode" = 2; # Block cookie banners
      "privacy.donottrackheader.enabled" = true;
      "privacy.fingerprintingProtection" = true;
      "privacy.resistFingerprinting" = true;
      "privacy.trackingprotection.emailtracking.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "layout.css.devPixelsPerPx" = scales.${hostName};
      "font.name.monospace.x-western" = "SauceCodePro Nerd Font";
    } // lib.optionalAttrs (hostName == "titan") {
      "font.size.monospace.x-western" = 14;
      "font.minimum-size.x-western" = 14;
    };
  };

  # environment.systemPackages = [ pkgs.firefox ];

  environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";
}
