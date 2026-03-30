{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../hypr/hyprland.nix
    inputs.ags.homeManagerModules.default
  ];

  # Packages
  home.packages = [
    inputs.astal.packages.${pkgs.system}.notifd
  ];

  # Ags
  programs.ags = {
    enable = true;
  };

  home.stateVersion = "26.05";
}
