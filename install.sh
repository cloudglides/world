#!/bin/sh

# Symlink NixOS config
sudo ln -sf ~/dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix

# Symlink Home Manager config
ln -sf ~/dotfiles/home-manager/home.nix ~/.config/home-manager/home.nix

# Reload configs
sudo nixos-rebuild switch
home-manager switch

echo "Dotfiles installed successfully!"

