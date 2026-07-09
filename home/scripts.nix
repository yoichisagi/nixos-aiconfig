{ pkgs, ... }:

let
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    choice=$(
      printf "󰌾 Lock\n󰍃 Logout\n󰤄 Suspend\n󰜉 Reboot\n Shutdown" |
      ${pkgs.wofi}/bin/wofi --dmenu --prompt "Power"
    )

    case "$choice" in
      "󰌾 Lock")
        ${pkgs.hyprlock}/bin/hyprlock
        ;;
      "󰍃 Logout")
        hyprctl dispatch exit
        ;;
      "󰤄 Suspend")
        ${pkgs.hyprlock}/bin/hyprlock
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
    pkgs.wofi
    pkgs.hyprlock
  ];
}
