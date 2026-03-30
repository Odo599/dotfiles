#!/usr/bin/env bash
set -e

echo "=== UPDATING SYSTEM ==="
sudo nixos-rebuild switch --flake ~/.config/nixos#nixos --impure

echo "=== FORMATTING ==="
nixfmt ~/.config/nixos/configuration.nix

echo "=== COMMITING TO GIT ==="
rev=$(readlink /nix/var/nix/profiles/system | grep -o "[0-9]*")
echo "Commiting revision $rev"
wd=$(pwd)
cd ~/.config/nixos
git add configuration.nix flake.nix flake.lock home.nix
git commit -m "nixos: $rev"
cd $wd
