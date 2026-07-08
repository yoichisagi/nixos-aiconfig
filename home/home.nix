{ config, pkgs, username, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./zsh.nix
    ./git.nix
  ];

  # Basic home packages
  home.packages = with pkgs; [
    # Terminal
    alacritty
    kitty
    
    # Tools
    fd
    bat
    eza
    lsd
    
    # Media
    mpv
    imagemagick
    
    # System monitoring
    btop
    htop
    
    # Misc
    tldr
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager should manage itself
  programs.home-manager.enable = true;
}
