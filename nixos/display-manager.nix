{ pkgs, ... }:

{
  # Disable other display managers
  services.displayManager.sddm.enable = false;

  # greetd login manager
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --remember \
            --asterisks \
            --sessions ${pkgs.tuigreet}/share/wayland-sessions \
            --cmd Hyprland
        '';

        user = " ";
      };
    };
  };

  # tuigreet package
  environment.systemPackages = with pkgs; [
    tuigreet
  ];
}
