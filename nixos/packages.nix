{
  config,
  lib,
  pkgs,
  ...
}:

{
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
    uv
    notcurses
    copyq
    zip
    unzip

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
    nemo
    vscode
    calibre
  ];


}
