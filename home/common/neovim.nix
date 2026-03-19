{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    #plugins = with pkgs.vimPlugins; [
    #  nvim-treesitter
    #  nvim-lspconfig
    #  nvim-web-devicons
    #  mason-nvim
    #  mason-lspconfig-nvim
    #];
  };
}
