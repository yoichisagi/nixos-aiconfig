{ config, pkgs, ... }:
{
  # Keyboard backlight support for ThinkPad T470s
  boot.kernelModules = [ "thinkpad_acpi" ];

  boot.extraModprobeConfig = ''
    options thinkpad_acpi brightness_enable=1
  '';

  # Keyboard backlight control via brightnessctl
  environment.systemPackages = with pkgs; [
    brightnessctl
    acpi
  ];

  # udev rules for brightness control without sudo
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/leds/%k/brightness"
  '';
}
