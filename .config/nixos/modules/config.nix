{
    config,
    lib,
    pkgs,
    inputs,
    ...
}:

{
    users.users.odo59 = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "input"
            "mlocate"
        ];
    };

    nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    boot = {
        initrd.systemd.enable = true;
        # Use the systemd-boot EFI boot loader.
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
    };

    # wifi
    networking = {
        networkmanager.enable = true;
        # networkmanager.dns = "none";
        nftables.enable = true;
        resolvconf.enable = false;
        firewall = {
            checkReversePath = "loose";
            allowedUDPPorts = [ config.services.tailscale.port ];
            allowedTCPPorts = [ 9090 ];
        };
    };

    systemd.network.wait-online.enable = false;
    systemd.services.resolvconf.enable = false;
    boot.initrd.systemd.network.wait-online.enable = false;

    time.timeZone = "Australia/Melbourne";

    nixpkgs.config.allowUnfree = true;

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    environment.sessionVariables = rec {
        NIXOS_OZONE_WL = "1";
        HYPRSHOT_DIR = "/home/odo59/Screenshots";
    };

    environment.variables = rec {
        SHELL = "fish";
    };

    swapDevices = [
        {
            device = "/swapfile";
            size = 16 * 1024;
        }
    ];

    console.keyMap = "dvorak";

    home-manager.backupFileExtension = "backup";

    services = {
        # sound
        pipewire = {
            enable = true;
            pulse.enable = true;
        };

        resolved.enable = true;
        upower.enable = true;

        # touchpad support
        libinput.enable = true;
        logind.settings.Login.HandlePowerKey = "ignore";
    };

    # server samba mount
    fileSystems."/mnt/smb0" = {
        device = "//100.100.1.1/samba";
        fsType = "cifs";
        options =
            let
                automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
            in
            [
                "${automount_opts},credentials=/etc/nixos/smb-secrets"
                "uid=1000"
                "gid=100"
            ];
    };

    # bluetooth
    hardware.bluetooth.enable = true;

    # enable nix-command
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    # Programs
    programs = {
        firefox.enable = true;
        hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        };
    };

    services = {
        blueman.enable = true;
        tailscale.enable = true;
        desktopManager.plasma6.enable = true;
    };

    # greetd
    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.tuigreet}/bin/tuigreet --cmd start-hyprland --asterisks -r";
            };
        };
    };

    # wayland security
    security.polkit.enable = true;

    xdg.portal.enable = true;

    users.groups.mlocate = { };

    fonts.fontconfig.enable = true;

    fonts.packages = with pkgs; [
        noto-fonts
        font-awesome
        roboto
        barlow
        inter
        googlesans-code
        nerd-fonts.fira-code
        nerd-fonts.monaspace
    ];

    system.stateVersion = "25.11"; # DO NOT CHANGE

    environment.systemPackages = with pkgs; [
        # Command Line tools
        fish
        vim
        neovim
        wget
        micro
        git
        tree
        file
        btop
        nodejs_24
        gh
        mlocate
        nixfmt-tree
        grim
        slurp
        libinput
        evtest
        ripgrep
        yazi
        tmux
        uv
        notcurses
        copyq
        zip
        unzip
        zoxide
        flutter
        stow
        jc
        jq
        tree-sitter
        bind # nslookup

        # system
        psmisc
        libnotify
        xdg-desktop-portal
        hyprpolkitagent
        libsForQt5.qtwayland
        pavucontrol
        bluez
        brightnessctl
        gccgo15
        python3
        hyprshot
        gvfs
        cifs-utils

        # hyprland
        hyprpaper
        hyprlock
        hypridle
        hyprpicker

        # background apps
        dunst
        rofi
        file-roller
        hyprcursor
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        networkmanagerapplet
        feh
        wlogout
        wl-clipboard
        eww
        quickshell

        # applications
        alacritty
        kitty
        nemo
        vscode
        calibre
        thunderbird
        vlc
    ];
}
