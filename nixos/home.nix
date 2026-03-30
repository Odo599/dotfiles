{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  # Packages
  home.packages = [
    inputs.astal.packages.${pkgs.system}.notifd
  ];

  # Ags
  programs.ags = {
    enable = true;
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      ################
      ### MONITORS ###
      ################
      monitor = [
        "eDP-1,preferred,auto,1.6"
      ];

      ###################
      ### MY PROGRAMS ###
      ###################
      "$terminal" = "alacritty";
      "$fileManager" = "nemo";
      "$menu" = "pidof rofi || rofi -show drun";
      "$browser" = "firefox";
      "$code" = "code";
      "$wlogout" = "pkill wlogout || wlogout";

      #################
      ### AUTOSTART ###
      #################
      exec-once = [
        "dunst"
        "systemctl --user start hyprpolkitagent"
        "quickshell"
        "hyprpaper"
        "eww open wallpaper && sleep 1 && pkill hyprpaper"
        "hypridle"
      ];

      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################
      env = [
        "XCURSOR_SIZE,30"
        "XCURSOR_THEME,Moga-Neon-Water"
        "HYPRCURSOR_SIZE,30"
        "HYPRCURSOR_THEME,Moga-Neon-Water"
      ];

      #####################
      ### LOOK AND FEEL ###
      #####################
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = true;
        allow_tearing = false;
      };

      decoration = {
        rounding = 7;
        rounding_power = 3;

        active_opacity = 1.0;
        inactive_opacity = 0.95;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global,1,10,default"
          "border,1,5.39,easeOutQuint"
          "windows,1,4.79,easeOutQuint"
          "windowsIn,1,4.1,easeOutQuint,popin 87%"
          "windowsOut,1,1.49,linear,popin 87%"
          "fadeIn,1,1.73,almostLinear"
          "fadeOut,1,1.46,almostLinear"
          "fade,1,3.03,quick"
          "layers,1,3.81,easeOutQuint"
          "layersIn,1,4,easeOutQuint,fade"
          "layersOut,1,1.5,linear,fade"
          "fadeLayersIn,1,1.79,almostLinear"
          "fadeLayersOut,1,1.39,almostLinear"
          "workspaces,1,1.94,almostLinear,fade"
          "workspacesIn,1,1.21,almostLinear,fade"
          "workspacesOut,1,1.94,almostLinear,fade"
          "zoomFactor,1,7,quick"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
      };

      #############
      ### INPUT ###
      #############
      input = {
        kb_layout = "us";
        kb_variant = "dvorak";
        follow_mouse = 1;
        sensitivity = 0;
        repeat_delay = 300;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };

      gesture = [
        "3, horizontal, workspace"
      ];

      gestures = {
        workspace_swipe_use_r = true;
      };

      device = [
        "name:apple-spi-trackpad,natural_scroll:true"
      ];

      ###################
      ### KEYBINDINGS ###
      ###################
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, B, exec, $browser"
        "$mainMod, C, exec, $code"
        "$mainMod, Z, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, J, togglesplit,"
        "$mainMod, F, fullscreen"
        "$mainMod SHIFT, S, exec, hyprshot -m region"
        "$mainMod, L, exec, loginctl lock-session"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, right, workspace, r+1"
        "$mainMod, left, workspace, r-1"

        ",xf86poweroff, exec, $wlogout"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, .config/scripts/volume up"
        ",XF86AudioLowerVolume, exec, .config/scripts/volume down"
        ",XF86AudioMute, exec, .config/scripts/volume mute"
        ",XF86AudioMicMute, exec, .config/scripts/volume mute"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };

    extraConfig = ''
      windowrule {
        name = nm-connection-editor
        match:class = nm-connection-editor
        move = 7 44
        float = 1
        pin = 1
      }
    '';
  };

  home.stateVersion = "26.05";
}
