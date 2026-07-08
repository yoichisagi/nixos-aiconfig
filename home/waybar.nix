{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    style = ''      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrains Mono", monospace;
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.8);
        color: #cdd6f4;
        border-bottom: 1px solid rgba(205, 214, 244, 0.2);
      }

      #workspaces {
        padding: 8px 10px;
      }

      #workspaces button {
        padding: 4px 8px;
        margin: 0 3px;
        border-radius: 5px;
        background: rgba(69, 71, 90, 0.5);
        color: #a6adc8;
        transition: all 0.3s ease;
      }

      #workspaces button:hover {
        background: rgba(102, 112, 134, 0.7);
        color: #cdd6f4;
      }

      #workspaces button.active {
        background: linear-gradient(135deg, #89dceb, #74c7ec);
        color: #1e1e2e;
        font-weight: bold;
        border-radius: 5px;
      }

      #workspaces button.urgent {
        background: #f38ba8;
        color: #1e1e2e;
      }

      #window {
        padding: 0 10px;
        color: #cdd6f4;
        font-weight: 500;
      }

      #clock {
        padding: 0 15px;
        color: #89dceb;
        font-weight: bold;
      }

      #network {
        padding: 0 10px;
        color: #a6e3a1;
        margin-right: 5px;
      }

      #network.disconnected {
        color: #f38ba8;
      }

      #battery {
        padding: 0 10px;
        color: #a6e3a1;
        margin-right: 5px;
      }

      #battery.charging {
        color: #89dceb;
      }

      #battery.critical {
        color: #f38ba8;
        animation: blink 1s infinite;
      }

      @keyframes blink {
        0%, 50% { opacity: 1; }
        51%, 100% { opacity: 0.5; }
      }

      #pulseaudio {
        padding: 0 10px;
        color: #f5c2e7;
        margin-right: 5px;
      }

      #pulseaudio.muted {
        color: #585b70;
      }

      #backlight {
        padding: 0 10px;
        color: #f9e2af;
        margin-right: 5px;
      }

      #cpu {
        padding: 0 10px;
        color: #f38ba8;
        margin-right: 5px;
      }

      #memory {
        padding: 0 10px;
        color: #fab387;
        margin-right: 5px;
      }

      #disk {
        padding: 0 10px;
        color: #94e2d5;
        margin-right: 5px;
      }

      #temperature {
        padding: 0 10px;
        color: #fab387;
        margin-right: 5px;
      }

      #temperature.critical {
        color: #f38ba8;
        animation: blink 1s infinite;
      }

      #bluetooth {
        padding: 0 10px;
        color: #89b4fa;
        margin-right: 5px;
      }

      #bluetooth.disconnected {
        color: #585b70;
      }

      #custom-separator {
        color: #45475a;
        padding: 0 5px;
      }

      #tray {
        padding: 0 10px;
      }
    '';
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        spacing = 0;
        
        modules-left = [ 
          "hyprland/workspaces" 
          "custom/separator"
          "hyprland/window" 
        ];
        modules-center = [ "clock" ];
        modules-right = [ 
          "custom/separator"
          "cpu"
          "memory"
          "disk"
          "temperature"
          "custom/separator"
          "network"
          "bluetooth"
          "battery"
          "backlight"
          "pulseaudio"
          "custom/separator"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            "1" = "󰲠";
            "2" = "󰲢";
            "3" = "󰲤";
            "4" = "󰲦";
            "5" = "󰲨";
            "6" = "󰢹";
            "7" = "󰢻";
            "8" = "󰢽";
            "9" = "󰢾";
            "10" = "󰢿";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
            "9" = [];
            "10" = [];
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
        };

        "clock" = {
          format = "󰃭 {:%H:%M:%S}";
          format-alt = "󰃰 {:%A, %B %d, %Y}";
          tooltip-format = "{:%A, %B %d, %Y}";
          interval = 1;
        };

        "cpu" = {
          format = "󰍛 {usage}%";
          tooltip = true;
          interval = 1;
        };

        "memory" = {
          format = "󰍘 {used:0.1f}G";
          tooltip = true;
          interval = 5;
        };

        "disk" = {
          format = "󰋊 {used}/{total}";
          tooltip = true;
          interval = 30;
          path = "/";
        };

        "temperature" = {
          thermal-zone = 0;
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = [ "" "" "" "" "" ];
          tooltip = true;
        };

        "network" = {
          format-wifi = "󰤨 {essid}";
          format-ethernet = "󰈀 Connected";
          format-disconnected = "󰌾 Disconnected";
          tooltip-format = "IP: {ipaddr}";
          interval = 5;
        };

        "bluetooth" = {
          format = "󰂯";
          format-connected = "󰂯 {num_connections}";
          format-disabled = "󰂲";
          tooltip-format = "{status}";
          on-click = "blueberry";
        };

        "battery" = {
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂅 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [ "󰂎" "󰂏" "󰂐" "󰂑" "󰂒" "󰂓" "󰂔" "󰂕" "󰂖" "󰂗" "󰂘" ];
          tooltip-format = "{time}";
          interval = 5;
        };

        "backlight" = {
          format = "󰛩 {percent}%";
          tooltip = true;
          scroll-step = 5;
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = [ "" "" "" ];
          on-click = "pavucontrol";
          scroll-step = 5;
          tooltip = true;
        };

        "custom/separator" = {
          format = "│";
        };

        "tray" = {
          icon-size = 16;
          spacing = 10;
        };
      };
    };
  };
}
