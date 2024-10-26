{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    kitty
  ]; 

  environment.sessionVariables = {
    TERM = "kitty";
  };
}
