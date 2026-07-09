{ config, pkgs, ... }:
{
  programs.zsh = {
  enable = true;
  enableCompletion = true;
  autocd = true;
  dotDir = "${config.xdg.configHome}/zsh";

  history = {
    path = "${config.xdg.dataHome}/zsh/history";
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

  initContent = ''
    autoload -Uz compinit
    compinit -u
  '';
};
}
