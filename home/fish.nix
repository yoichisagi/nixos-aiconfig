{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "eza";
      ll = "eza -la";
      cat = "bat";
      v = "nvim";
      vim = "nvim";
    };

    interactiveShellInit = ''
          set -g fish_greeting
          zoxide init fish | source
          starship init fish | source
    '';
  };
}
