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
    nameservers = [
        "100.100.100.100"
        "1.1.1.1"
        "8.8.8.8"
    ];
}
