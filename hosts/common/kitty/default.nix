{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    kitty
  ]; 

  environment.variables = {
    TERM = "kitty";
  };
}
