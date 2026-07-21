{
  config,
  pkgs,
  ...
}: {
  home.username = "ethang";
  home.homeDirectory = "/home/ethang";
  home.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ../common/packages.nix
    ../common/zsh.nix
    ../common/neovim.nix
    ../common/git.nix
    ../common/gnome.nix
    ../common/tmux.nix
    ../common/ssh.nix
  ];

  programs.home-manager.enable = true;

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };
}
