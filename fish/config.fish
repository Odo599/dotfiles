if status is-interactive
    abbr --add nixconf micro ~/.config/nixos/conf.nix
    abbr --add nixbuild bash ~/.config/nixos/update.sh
    abbr --add nixpush git -C ~/.config/nixos push
    abbr --add nixlint nixfmt --indent=4 .config/nixos/conf.nix
    abbr --add nixgit git -C ~/.config/nixos
end
