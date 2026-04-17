set fish_greeting

if status is-interactive
    abbr --add nixconf nvim -p ~/.config/nixos/configuration.nix ~/.config/nixos/flake.nix
    abbr --add nixbuild bash ~/.config/nixos/update.sh
    abbr --add nixpush git -C ~/.config/nixos push
    abbr --add nixlint nixfmt .config/nixos/configuration.nix
    abbr --add nixgit git -C ~/.config

    abbr --add exitup sudo tailscale set --exit-node=home-server
    abbr --add exitdown sudo tailscale set --exit-node=

    eww shell-completions --shell fish | source
end
