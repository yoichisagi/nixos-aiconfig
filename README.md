# NixOS Flake Configuration

A modern NixOS system configuration using Flakes and Home Manager for a Lenovo ThinkPad T470s with Hyprland window manager and Stylix for consistent theming.

## Features

- **Flake-based configuration** - Modern, reproducible NixOS setup
- **Home Manager** - User-level package and dotfile management
- **Hyprland** - Wayland tiling window manager
- **Stylix** - System-wide consistent theming and color management
- **Waybar** - Customizable status bar for Hyprland
- **Intel GPU** - Optimized for Intel integrated graphics
- **Bluetooth Support** - Full Bluetooth connectivity with blueman GUI
- **Keyboard Backlight** - Control keyboard backlight brightness
- **KDE Plasma** - Alternative desktop environment option
- **ThinkPad T470s** - Hardware-specific optimizations via nixos-hardware

## Structure

```
.
├── flake.nix                 # Flake configuration (Unstable)
├── flake.lock                # Lock file for reproducibility
├── README.md
├── nixos/
│   ├── configuration.nix     # System configuration
│   ├── hyprland.nix          # Hyprland setup
│   ├── bluetooth.nix         # Bluetooth configuration
│   ├── keyboard-backlight.nix # Keyboard backlight setup
│   ├── display-manager.nix   # Display manager configuration
│   ├── kde.nix               # KDE Plasma configuration
│   ├── power.nix             # Power management settings
│   ├── stylix.nix            # Stylix theming configuration
│   └── hardware-configuration.nix  # Hardware config (regenerate after install)
├── home/
│   ├── home.nix              # Home Manager entry point
│   ├── hyprland.nix          # Hyprland user config with keybindings
│   ├── zsh.nix               # Zsh shell configuration
│   ├── fish.nix              # Fish shell configuration
│   ├── git.nix               # Git configuration
│   ├── waybar.nix            # Waybar status bar configuration
│   ├── scripts.nix           # User scripts
│   └── wallpapers/           # Wallpaper directory
```

## Prerequisites

1. Fresh NixOS installation on ThinkPad T470s
2. Git installed
3. This repository cloned to `~/.config/nixos` or `/etc/nixos`

## Initial Setup

### 1. Generate Hardware Configuration

After booting into NixOS:

```bash
sudo nixos-generate-config --show-hardware-config > ~/.config/nixos/nixos/hardware-configuration.nix
```

Update the UUID placeholders in `hardware-configuration.nix` with your actual UUIDs:

```bash
blkid
```

### 2. Update Git Email

Edit `home/git.nix` and change the email to your actual email:

```nix
userEmail = "your-actual-email@example.com";
```

### 3. Build and Switch

```bash
cd ~/.config/nixos
sudo nixos-rebuild switch --flake .#komi
```

## Feature Configuration

### Bluetooth

**Status:**
- Bluetooth is enabled and starts at boot
- Blueman provides a GUI for managing Bluetooth devices
- Devices can be connected via `blueberry` GUI or command line

**Commands:**
```bash
# View Bluetooth devices
bluetoothctl devices

# Pair a device
bluetoothctl pair <device_address>

# Connect to device
bluetoothctl connect <device_address>
```

### Keyboard Backlight

**Status:**
- Keyboard backlight is controlled via ThinkPad ACPI module
- Use Hyprland hotkeys or `brightnessctl` command

**Hotkeys in Hyprland:**
- `Fn + PageUp` - Increase keyboard brightness
- `Fn + PageDown` - Decrease keyboard brightness

**Commands:**
```bash
# Check available backlight devices
brightnessctl -l

# Increase keyboard backlight by 10%
brightnessctl -d '*::kbd_backlight' set +10%

# Decrease keyboard backlight by 10%
brightnessctl -d '*::kbd_backlight' set 10%-

# Set to specific value (0-100)
brightnessctl -d '*::kbd_backlight' set 50
```

### Stylix Theming

Stylix provides system-wide consistent theming. Configuration is in `nixos/stylix.nix`.

**Features:**
- Automatic color scheme generation from wallpapers
- Consistent theming across GTK, Qt, and terminal applications
- Easy color palette customization

### Waybar Status Bar

Waybar is configured as the status bar for Hyprland. Customize appearance and modules in `home/waybar.nix`.

### Hyprland

Hyprland is the primary window manager. Configure keybindings, monitor layout, and appearance in `home/hyprland.nix`.

## Customization

### Adding Packages

Add packages to:
- **System-wide**: `nixos/configuration.nix` → `environment.systemPackages`
- **User packages**: `home/home.nix` → `home.packages`

### Hyprland Configuration

Edit keybindings and settings in `home/hyprland.nix`:
- Monitor configuration
- Keybindings (search for `bind = [ ... ]`)
- Appearance (gaps, borders, animations)

### Shell Configuration

Customize shell settings in:
- `home/zsh.nix` - Zsh shell configuration
- `home/fish.nix` - Fish shell configuration

Available options:
- Aliases
- Plugins
- History settings

### Statusbar Configuration

Customize Waybar in `home/waybar.nix`:
- Module layout
- Colors and styling
- Click commands

## Useful Commands

```bash
# Rebuild and switch to new configuration
sudo nixos-rebuild switch --flake .#komi

# Test new configuration without switching
sudo nixos-rebuild test --flake .#komi

# Rollback to previous generation
sudo nixos-rebuild --rollback

# Update flake inputs
nix flake update

# Enter development shell
nix develop

# Format nix files
nixpkgs-fmt .
```

## Troubleshooting

### Bluetooth not working
- Ensure Bluetooth is enabled: `systemctl status bluetooth`
- Check if device is visible: `bluetoothctl scan on`
- Check kernel modules: `lsmod | grep bluetooth`

### Keyboard backlight not working
- Check available devices: `brightnessctl -l`
- Verify ThinkPad ACPI module: `lsmod | grep thinkpad_acpi`
- Check sysfs path: `ls /sys/class/leds/` or `ls /sys/class/backlight/`

### Display issues
- Check monitor configuration in `home/hyprland.nix`
- Run `hyprctl monitors` to see detected monitors

### GPU acceleration not working
- Verify Intel drivers are loaded: `glxinfo | grep "OpenGL"`
- Check `nixos/hyprland.nix` for GPU settings

### Sound issues
- Use `pavucontrol` to check audio settings
- Verify pipewire is running: `systemctl --user status pipewire`

### Waybar not showing
- Check Hyprland configuration for waybar exec commands
- Verify `home/waybar.nix` is correctly configured
- Check systemctl: `systemctl --user status waybar`

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Flakes Documentation](https://nixos.wiki/wiki/Flakes)
- [ThinkPad ACPI](https://www.kernel.org/doc/html/latest/admin-guide/laptops/thinkpad-acpi.html)
- [Stylix Documentation](https://github.com/danth/stylix)

## License

MIT
