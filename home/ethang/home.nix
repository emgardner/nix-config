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
    ./modules/packages.nix
    ./modules/zsh.nix
    ./modules/neovim.nix
    ./modules/git.nix
    ./modules/gnome.nix
  ];

  programs.home-manager.enable = true;

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };
}
