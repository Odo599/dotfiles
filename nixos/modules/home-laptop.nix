{
  config,
  lib,
  pkgs,
  ...
}:

{
    imports = [ ./hardware/home-laptop.nix ];
    networking.hostName = "nixos-home";
    services.flatpak.enable = true;

    users.users.odo59 = {
        subUidRanges = [
            { startUid = 100000; count = 65536; }
        ];
        subGidRanges = [
            { startGid = 100000; count = 65536; }
        ];
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };
    
    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [
        bottles
        mesa
        vulkan-tools
        mesa-demos
    ];
}
