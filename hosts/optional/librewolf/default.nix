{ lib, config, pkgs, ... }:
let
  hostName = config.networking.hostName;
  scales = {
    nixos = "1.60";
    nixvirt = "1.25";
    galaxy = "1.15";
    legion = "1.25";
    titan = "1.0";
  };
in
{
  programs.firefox = {
    package = pkgs.librewolf;
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
    } // lib.optionalAttrs (hostName == "titan") {
      "font.name.monospace.x-western" = "SauceCodePro Nerd Font";
      "font.size.monospace.x-western" = 14;
      "font.minimum-size.x-western" = 14;
    };
  };

  environment.systemPackages = [ pkgs.firefox ];

  environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";
}
