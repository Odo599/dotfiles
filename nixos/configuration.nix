{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  specific_config = /home/odo59/.config/nixos/specific_configuration.nix;
in
{
  imports = [
    ./hardware-configuration.nix
  ]
  ++ (if builtins.pathExists specific_config then [ specific_config ] else [ ]);

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
    networkmanager.dns = "none";
    nftables.enable = true;
    resolvconf.enable = false;
    nameservers = [
      "100.100.1.1"
      "1.1.1.1"
      "8.8.8.8"
    ];
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
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  users.groups.mlocate = { };

  environment.systemPackages = with pkgs; [
    # Command Line Tools
    fish
    vim
    neovim
    wget
    micro
    git
    tree
    file
    htop
    entr
    bind
    cargo
    xeyes
    nodejs_24
    gh
    statix
    mlocate
    nixfmt
    direnv
    grim
    slurp
    libinput
    evtest
    ripgrep
    yazi
    tmux

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
    zip
    unzip

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
    nemo
    jetbrains.webstorm
    vscode
    calibre
  ];

  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
    roboto
    barlow
    inter
    googlesans-code
    nerd-fonts.fira-code
  ];

  system.stateVersion = "25.11"; # DO NOT CHANGE
}
