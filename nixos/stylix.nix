{ pkgs, lib, ... }:

{
  stylix = {
    enable = true;

    base16Scheme =
      "${pkgs.base16-schemes}/share/themes/horizon-dark.yaml";

    polarity = "dark";

    targets = {
      qt = {
        enable = true;
        platform = lib.mkForce "qtct";
      };

      gtk.enable = true;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };

}
