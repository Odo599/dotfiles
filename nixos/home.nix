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
        ./modules/hyprland/hyprland.nix
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

    xdg.enable = true;

    xdg.configFile."menus/applications.menu".text = ''
      <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
       "http://freedesktop.org">
      <Menu>
        <Name>Applications</Name>
        <DefaultAppDirs/>
        <DefaultDirectoryDirs/>
        <Include>
          <All/>
        </Include>
      </Menu>
    '';


    home.stateVersion = "26.05";
}
