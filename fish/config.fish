if status is-interactive
    abbr --add nixconf micro ~/.config/nixos/conf.nix
    abbr --add nixbuild bash ~/.config/nixos/update.sh
    abbr --add nixpush git -C ~/.config/nixos push
    abbr --add nixlint nixfmt .config/nixos/conf.nix
    abbr --add nixgit git -C ~/.config

    abbr --add exitup sudo tailscale set --exit-node=home-server
    abbr --add exitdown sudo tailscale set --exit-node=
end
