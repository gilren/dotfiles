#!/bin/bash

set -e

echo -e "\e[32m\nUpdate system packages\e[0m"
sudo pacman -Syu --noconfirm

# Update AUR packages if any are installed
if pacman -Qem >/dev/null 2>&1; then
  echo -e "\e[32m\nUpdate AUR packages\e[0m"
  yay -Sua --noconfirm || echo -e "\e[31mFailed to update AUR packages\e[0m"
fi

orphans=$(pacman -Qtdq || true)
if [[ -n $orphans ]]; then
  echo -e "\e[32m\nRemove orphan system packages\e[0m"
  for pkg in $orphans; do
    sudo pacman -Rs --noconfirm "$pkg" || true
  done
  echo
fi
