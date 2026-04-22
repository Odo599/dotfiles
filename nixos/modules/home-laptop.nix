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

    programs.steam.enable = true;

}
