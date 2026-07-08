{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    
    history = {
      dir = "$HOME/.local/share/zsh";
      size = 50000;
      save = 50000;
      share = true;
    };

    shellAliases = {
      ls = "eza";
      ll = "eza -la";
      cd = "z";
      cat = "bat";
      v = "nvim";
      vim = "nvim";
      grep = "grep --color=auto";
    };

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = "${pkgs.zsh-nix-shell}/share/zsh-plugins/zsh-nix-shell";
      }
    ];

    initExtra = '''
      # Additional zsh configuration
      export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
      mkdir -p "$(dirname $ZSH_COMPDUMP)"
    ''';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
