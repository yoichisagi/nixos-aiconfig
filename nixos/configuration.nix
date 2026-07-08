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
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Use latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.networkmanager.enable = true;

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

  # User account
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "docker" "input" ];
    shell = pkgs.zsh;
  };

  # Packages
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
    
    # Media and volume control
    pamixer
    playerctl
    grim
    slurp
    pavucontrol
    
    # Fonts for Waybar
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    
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
  };

  # NixOS settings
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
