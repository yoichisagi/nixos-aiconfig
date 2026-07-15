{ config, pkgs, ... }:

let
  lib = pkgs.lib;
  secretPath = "${config.home.homeDirectory}/.config/nixpkgs/git-secrets.nix";
  hasSecrets = builtins.pathExists secretPath;
  secrets = if hasSecrets then import secretPath else {};
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = (if hasSecrets then { user = secrets.user; } else {}) // {
      core = {
        editor = "nvim";
        pager = "delta";
        excludesfile = "${config.home.homeDirectory}/.gitignore_global";
      };

      pull = { rebase = true; };
      init = { defaultBranch = "main"; };

      color = { ui = true; };
      push = { default = "simple"; };
      credential = { helper = "cache --timeout=3600"; };

      commit = { gpgSign = true; };
      gpg = { program = "gpg"; };

      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        unstage = "reset HEAD --";
        last = "log -1 --stat";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  home.file.".gitignore_global".text = ''
    .DS_Store
    *.swp
    .idea/
    .vscode/
    .env
    node_modules/
    dist/
  '';
}
