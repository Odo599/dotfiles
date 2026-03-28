{
  description = "flake"

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
  }

  outputs = { self, nixpkgs, home-manager, hyprland, Hyprspace, ... }:
    let system = "aarch64-linux"; in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./conf.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.odo59 = import ./home.nix;

            _module.args = {
              inherit hyprland Hyprspace;
            };
          }
        ];
      };
    };
}