{ pkgs, ... }:

let
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    choice=$(
      printf "󰌾 Lock\n󰍃 Logout\n󰤄 Suspend\n󰜉 Reboot\n Shutdown" |
      ${pkgs.rofi}/bin/rofi -dmenu -p "Power"
    )

    case "$choice" in
      "󰌾 Lock")
        ${pkgs.hyprlock}/bin/hyprlock
        ;;

      "󰍃 Logout")
        hyprctl dispatch exit
        ;;

      "󰤄 Suspend")
        ${pkgs.hyprlock}/bin/hyprlock &
        sleep 1
        systemctl suspend
        ;;

      "󰜉 Reboot")
        systemctl reboot
        ;;

      " Shutdown")
        systemctl poweroff
        ;;
    esac
  '';
in
{
  home.packages = [
    powermenu
 #   pkgs.rofi
    pkgs.hyprlock
    pkgs.hyprland
  ];
}
