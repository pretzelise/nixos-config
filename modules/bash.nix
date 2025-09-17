{ pkgs, config, hostname, ... }: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      vim = "nvim";
      upgrade = "nix flake update";
      rebuild = "sudo nixos-rebuild switch --flake ~/.nixos-config";
    };
  };
}
