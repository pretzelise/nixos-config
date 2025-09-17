{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # nixos-wsl
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zen-browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixos-wsl,
      home-manager,
      zen-browser,
      ...
    }:
    {

      # Specify nixfmt
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;

      nixosConfigurations = {

        # Home PC
        elise-pc = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/elise-pc/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Import home.nix
              home-manager.users.elise = import ./hosts/elise-pc/home.nix;

              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }
          ];
        };

        # WSL environment
        elise-wsl = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/elise-wsl/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Import home.nix
              home-manager.users.elise = import ./hosts/elise-wsl/home.nix;

              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }

            nixos-wsl.nixosModules.default
            {
              wsl.enable = true;
              system.stateVersion = "25.05";
            }
          ];
        };
      };
    };
}
