{
  config,
  pkgs,
  ...
}: {
  home.username = "ethang";
  home.homeDirectory = "/home/ethang";
  home.stateVersion = "25.11";

  imports = [
    ../common/packages.nix
    #../common/zsh.nix
    ../common/shell/zsh
    #../common/neovim.nix
    ../common/git.nix
    ../common/gnome.nix
    ../common/tmux.nix
    ../common/ssh.nix
  ];

  programs.home-manager.enable = true;

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      shell-integration-features = "ssh-terminfo,ssh-env";
    };
  };
}
