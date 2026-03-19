{
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./p10k;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        # "pay-respects"
      ];
      theme = "robbyrussell";
    };

    # Run late; override OMZ/plugin aliases
    initContent = lib.mkOrder 1500 ''
      # unalias ll 2>/dev/null
      # unalias la 2>/dev/null
      bindkey '\t' autosuggest-accept
      alias ll="eza -l"
      alias la="eza -la"
      alias cat="bat"
      alias grep="rg"
      alias find="fd"
      alias update='nix flake update "$HOME/nix-config"'
      alias rebuild='sudo nixos-rebuild switch --flake "$HOME/nix-config#nixos"'
      alias hms='home-manager switch --flake "$HOME/nix-config#$(whoami)@$(hostname)"'
      alias g="git"
      alias gs="git status"
      alias gc="git commit"
      alias gcs="git commit -m \"sync\""
      alias gp="git push"
      alias cdp="cd ~/projects"
      alias eh="nvim ~/nix-config"
    '';
  };
}
