{ config, pkgs, inputs, ... }:

{
  home.username = "elise";
  home.homeDirectory = "/home/elise";

  imports = [
    # Extra modules to import
    ../../modules/bash.nix
    ../../modules/git.nix
    ../../modules/neovim.nix
  ];

  # Packages to install
  home.packages = with pkgs; [
    freshfetch
    jq
    bat

    inputs.zen-browser.packages."x86_64-linux".twilight
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
