{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "shousuke";
    userEmail = "your-email@example.com"; # Change this!
    
    extraConfig = {
      core.editor = "nvim";
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
}
