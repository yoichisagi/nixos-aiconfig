{ pkgs, ... }:

{
  services.tlp = {
    enable = true;

    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      WIFI_PWR_ON_BAT = 1;
    };
  };

  services.power-profiles-daemon.enable = false;

  environment.systemPackages = with pkgs; [
    powertop
    acpi
  ];
}
