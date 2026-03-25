{
  config,
  lib,
  pkgs,
  ...
}:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };
in
{
  boot = {
    initrd.systemd.enable = true;
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  # wifi
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nftables.enable = true;
    nameservers = [
      "100.100.1.1"
      "1.1.1.1"
      "8.8.8.8"
    ];
    firewall = {
      checkReversePath = "loose";
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  time.timeZone = "Australia/Melbourne";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

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

  services = {
    # sound
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # touchpad support
    libinput.enable = true;
  };

  # server samba mount
  fileSystems."/mnt/smb0" = {
    device = "//100.100.1.1/samba";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
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
    hyprland.enable = true;
    waybar.enable = true;
  };

  services = {
    blueman.enable = true;
    tailscale.enable = true;
    resolved.enable = true;
  };

  # greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd Hyprland --asterisks -r";
      };
    };
  };

  # wayland security
  security.polkit.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  users.groups.mlocate = { };

  environment.systemPackages = with pkgs; [
    # Command Line Tools
    fish
    vim
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
    unstable.hyprls
    nixfmt
    direnv

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
    upower

    # hyprland
    hyprland
    hyprpaper
    hyprlock
    hypridle

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
    eww
    quickshell

    # applications
    alacritty
    nemo
    jetbrains.webstorm
    vscode
  ];

  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    font-awesome
    roboto
    barlow
    inter
  ];
}
