#/run/current-system/sw/bin/bash
set -e

echo "=== UPDATING SYSTEM ==="
sudo nixos-rebuild switch

echo "=== FORMATTING ==="
nixfmt .config/nixos/conf.nix

echo "=== COMMITING TO GIT ==="
rev=$(readlink /nix/var/nix/profiles/system | grep -o "[0-9]*")
echo "Commiting revision $rev"
wd=$(pwd)
cd ~/.config/nixos
git add conf.nix
git commit -m "nixos: $rev"
cd $wd
