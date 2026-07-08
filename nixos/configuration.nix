{ config, pkgs, username, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
    ./bluetooth.nix
    ./keyboard-backlight.nix
    ./kde.nix
  ];

  # System hostname and time
  networking.hostName = hostname;
  networking.domain = "";
  networking.search = [];
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Use latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.networkmanager.enable = true;
  
  # Enable mDNS for hostname resolution
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Audio
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # Graphics - Intel GPU
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva-utils
    ];
  };
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
  };

  # Systemd for temperature monitoring
  services.thermald.enable = true;

  # User account
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "docker" "input" "audio" ];
    shell = pkgs.zsh;
  };

  # Packages - Core System
  environment.systemPackages = with pkgs; [
    # Core utilities
    git
    curl
    wget
    vim
    neovim
    htop
    tree
    fzf
    ripgrep
    tmux
    zsh
    
    # Development
    gcc
    gnumake
    pkg-config
    
    # Bluetooth
    bluez
    bluez-tools
    blueberry
    
    # Keyboard backlight
    brightnessctl
    acpi
    
    # Volume and Media Control (REQUIRED for Hyprland bindings)
    pamixer
    playerctl
    
    # Screenshot utilities (REQUIRED for Hyprland bindings)
    grim
    slurp
    
    # Audio control GUI
    pavucontrol
    
    # Fonts for Waybar icons and terminals
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    
    # System monitoring
    lm-sensors
    
    # Applications
    firefox
    alacritty
    rofi
    dunst
    thunar
  ];

  # Shell
  programs.zsh.enable = true;

  # Locale
  environment.variables = {
    EDITOR = "nvim";
    QT_QPA_PLATFORMTHEME = "kde";
  };

  # NixOS settings
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
