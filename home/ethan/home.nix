{
  config,
  pkgs,
  ...
}: {
  home.username = "ethan";
  home.homeDirectory = "/home/ethan";
  home.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ../common/packages.nix
    ../common/zsh.nix
    ../common/git.nix
    ../common/tmux.nix
    ../common/ssh.nix
  ];

  programs.home-manager.enable = true;

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };
}
