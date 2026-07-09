{ config, pkgs, ... }:
{
  # Bluetooth support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        ControllerMode = "bredr";
      };
    };
  };

  # Bluetooth service
  services.blueman.enable = true;

  # Additional Bluetooth packages
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    blueman  # GUI Bluetooth manager
  #  pulseaudio-modules-bt  # For PulseAudio Bluetooth support
  ];

  # Enable udev rules for Bluetooth devices
  services.udev.packages = with pkgs; [ bluez ];
}
