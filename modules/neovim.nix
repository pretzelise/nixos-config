{ pkgs, config, ... }: {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
      nvim-treesitter-parsers.nix
    ];
  };
}
