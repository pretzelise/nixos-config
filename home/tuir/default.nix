{ pkgs, config, ... }: {
  home.file.".config/tuir/tuir.cfg".source = ./tuir.cfg;
}
