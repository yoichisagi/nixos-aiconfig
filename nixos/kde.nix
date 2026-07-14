{ config, pkgs, ... }:
{
  # KDE Plasma desktop environment (backup for Hyprland)
  services.desktopManager.plasma6.enable = true;

  # SDDM display manager (shared with Hyprland)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
 #   theme = "breeze";
  };

  # KDE Plasma packages
  environment.systemPackages = with pkgs; [
    # Core KDE Plasma
    kdePackages.plasma-desktop
    kdePackages.kdeplasma-addons
    kdePackages.plasma-workspace-wallpapers
    
    # KDE Applications
    kdePackages.dolphin           # File manager
    kdePackages.konsole           # Terminal
    kdePackages.kate              # Text editor
    kdePackages.gwenview          # Image viewer
    kdePackages.okular            # PDF viewer
    kdePackages.ark               # Archive manager
    kdePackages.kcalc             # Calculator
    
    # System utilities
    kdePackages.kinfocenter       # System information
    kdePackages.systemsettings    # System settings
    kdePackages.plasma-systemmonitor  # System monitor
  ];

  # KDE Connect for device integration
  #  programs.kdeconnect.enable = true;

  # Integrate Qt with system theme
  #qt = {
  #  enable = true;
  #  platformTheme = "qtct";
  #};
}
