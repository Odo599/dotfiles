#!/usr/bin/env bash
set -e

echo "=== UPDATING SYSTEM ==="
echo "> sudo nixos-rebuild switch --flake ~/.config/nixos#nixos --impure"
sudo nixos-rebuild switch --flake ~/.config/nixos#nixos --impure

echo "=== FORMATTING ==="
echo "> nixfmt ~/.config/nixos/configuration.nix"
nixfmt ~/.config/nixos/configuration.nix

echo "=== COMMITING TO GIT ==="
rev=$(readlink /nix/var/nix/profiles/system | grep -o "[0-9]*")
echo "Commiting revision $rev"
echo "> cd ~/.config/nixos"
cd ~/.config/nixos
echo "> git add configuration.nix flake.nix flake.lock home.nix ../hypr/hyprland.conf ../hypr/hyprland.nix"
git add configuration.nix flake.nix flake.lock home.nix ../hypr/hyprland.nix
echo '> git commit -m "nixos: $rev"'
git commit -m "nixos: $rev"
