# Specific services and packages to allow ec2 nixos operations
{ pkgs, ... }:
{
  services.amazon-ssm-agent.enable = true;
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "prohibit-password";
  services.udev.packages = [ pkgs.amazon-ec2-utils ];
  services.udisks2.enable = false;

  # Enable the serial console on ttyS0
  systemd.services."serial-getty@ttyS0".enable = true;

  environment.systemPackages = with pkgs; [
    amazon-ssm-agent
    amazon-ec2-utils
    awscli2
    aws-c-mqtt
    aws-c-http
    aws-c-compression
    aws-c-sdkutils
    aws-c-auth
    aws-c-compression
    aws-c-io
    aws-c-cal
    aws-c-auth
    aws-c-event-stream
    aws-crt-cpp
    aws-crt-cpp
    aws-c-mqtt
    aws-c-s3
    aws-c-common
    aws-c-event-stream
    aws-c-s3
    aws-c-common
    aws-c-sdkutils
    aws-c-http
    aws-c-io
    aws-checksums
    aws-c-cal
    cryptsetup
  ];
}
