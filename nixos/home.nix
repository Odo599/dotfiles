{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.stateVersion = "26.05";
  wayland.windowManager.hyprland.enable = true;
}
