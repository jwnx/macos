{
  description = "MacOS configurations";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homemanager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nur, ... }@inputs:
    let
      sharedDarwinConfiguration = { config, pkgs, ... }: {
        nix = {
          package = pkgs.nixFlakes;

          extraOptions = ''
            experimental-features = nix-command flakes
          '';

          settings.substituters = [
            "https://cache.nixos.org"
          ];

          gc = {
            automatic = true;
            options = "--delete-older-than 2w";
          };
        };

        nixpkgs = {
          config = {
            allowUnfree = true;
            allowUnsupportedSystem = false;
            allowInsecure = true;
          };

          overlays = [
            self.overlay
            nur.overlay
          ];
        };
      };
    in
    {
      overlay = import ./overlays;

      darwinConfigurations = {
        discovery = inputs.darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          inherit inputs;

          modules = [
            inputs.homemanager.darwinModules.home-manager
            inputs.agenix.nixosModules.age
            sharedDarwinConfiguration
            ./machines/discovery
            ./users/jwnx
          ];
        };

        solvang = inputs.darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          inherit inputs;

          modules = [
            inputs.homemanager.darwinModules.home-manager
            inputs.agenix.nixosModules.age
            sharedDarwinConfiguration
            ./machines/solvang
            ./users/arbusto
          ];
        };
    };

    discovery = self.darwinConfigurations.discovery.system;
  };
}
