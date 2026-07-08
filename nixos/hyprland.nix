{ config, pkgs, ... }:
{
  # Hyprland window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Required for Hyprland
  security.pam.services.hyprlock = {};

  # Polkit for system actions
  security.polkit.enable = true;

  # XDG portal for file dialogs
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  environment.systemPackages = with pkgs; [
    # Hyprland ecosystem
    hyprland
    hyprlock
    hypridle
    hyprpicker
    hyprshot
    waybar
    wl-clipboard
    cliphist
    
    # Wayland utilities
    wayland
    wayland-protocols
    xwayland
  ];
}
