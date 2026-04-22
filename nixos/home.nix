{
    config,
    pkgs,
    inputs,
    ...
}:
let
    hyprland_specific = /home/odo59/.config/hypr/hyprland_specific.nix;
in
{
    imports = [
        ../hypr/hyprland.nix
        inputs.ags.homeManagerModules.default
    ]
    ++ (if builtins.pathExists hyprland_specific then [ hyprland_specific ] else [ ]);

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
