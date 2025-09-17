{ pkgs, config, ... }:
{
  programs.git = {
    enable = true;
    userName = "Elise Onn";
    userEmail = "mail@elise.gg";
  };
}
