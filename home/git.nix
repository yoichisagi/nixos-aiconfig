{ config, pkgs, ... }:
{
  programs.git = {
  enable = true;
    lfs.enable = true;

  delta.enable = true;

  settings = {
    user = {
      name = "komi7";
      email = "korea.ashik@gmail.com";
    };

    core.editor = "nvim";
    pull.rebase = true;
    init.defaultBranch = "main";
  };
};
}
