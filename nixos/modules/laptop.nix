{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    "/home/odo59/.config/nixos/apple-silicon-support"
    "/home/odo59/.config/nixos/modules/hardware/laptop.nix"
  ];
}
