#/run/current-system/sw/bin/bash
set -e

echo "=== UPDATING SYSTEM ==="
sudo nixos-rebuild switch -I nixos-config=/home/odo59/.config/nixos/configuration.nix

echo "=== FORMATTING ==="
nixfmt ~/.config/nixos/configuration.nix

echo "=== COMMITING TO GIT ==="
rev=$(readlink /nix/var/nix/profiles/system | grep -o "[0-9]*")
echo "Commiting revision $rev"
wd=$(pwd)
cd ~/.config/nixos
git add configuration.nix
git commit -m "nixos: $rev"
cd $wd
