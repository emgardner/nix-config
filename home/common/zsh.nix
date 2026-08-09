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
      ];
      theme = "robbyrussell";
    };

    # Run late; override OMZ/plugin aliases
    initContent = lib.mkOrder 1500 ''
        # unalias ll 2>/dev/null
        # unalias la 2>/dev/null
        hms() {
          local user_name="$USER"
          local host_name="''${HOST%%.*}"
          local flake="$HOME/nix-config#$user_name@$host_name"
          echo "Switching Home Manager configuration: $flake"
          home-manager switch -b backup --flake "$flake" "$@"
        }
        rebuild() {
          local user_name="$USER"
          local host_name="''${HOST%%.*}"
          local flake="$HOME/nix-config#$user_name@$host_name"
          sudo nixos-rebuild switch --flake "$HOME/nix-config#$host_name"
        }
        # bindkey '\t' autosuggest-accept
        # Tab = normal contextual completion, including filenames
        bindkey '^I' expand-or-complete
        # Right arrow accepts the gray history suggestion

      bindkey '^[[C' autosuggest-accept
        alias ll="eza -l"
        alias la="eza -la"
        alias cat="bat"
        alias grep="rg"
        alias find="fd"
        alias update='nix flake update "$HOME/nix-config"'
        alias g="git"
        alias gs="git status"
        alias gc="git commit"
        alias gcs="git commit -m \"sync\""
        alias gp="git push"
        alias cdp="cd ~/projects"
        alias eh="nvim ~/nix-config"
        alias yz="yazi"
        eval "$(direnv hook zsh)"
    '';
  };
}
