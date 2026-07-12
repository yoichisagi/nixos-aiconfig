{ config, pkgs, username, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.11";

  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./fish.nix
    ./git.nix
    ./scripts.nix
  ];

  # Basic home packages
  home.packages = with pkgs; [
    # Terminal
    alacritty
    kitty
    brave
    
    #torrent
    qbittorrent
    
    # Tools
    fd
    bat
    eza
    lsd
    jq
    unzip
    zip
    wget
    curl
    git-lfs
    dunst
    
    # Media
    mpv
    imagemagick
    
    #office
    onlyoffice-desktopeditors
    corefonts
    vista-fonts
    liberation_ttf
    dejavu_fonts
    noto-fonts
    
    # System monitoring
    btop
    htop
    
    # Misc
    tldr
  ];

  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

  # Home Manager should manage itself
  programs.home-manager.enable = true;
}
