{
    description = "flake for nixos";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland = {
            url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        astal.url = "github:aylur/astal";
        ags.url = "github:aylur/ags";
    };

    outputs =
    {
        self,
        nixpkgs,
        hyprland,
        ...
    }@inputs:
    {
        nixosConfigurations = {
            laptop = nixpkgs.lib.nixosSystem {
                system = "aarch64-linux";
                specialArgs = {
                    inherit inputs;
                };

                modules = [
                    /home/odo59/.config/nixos/modules/config.nix
                    /home/odo59/.config/nixos/modules/laptop.nix
                    inputs.home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.extraSpecialArgs = {
                            inherit inputs;
                        };
                        home-manager.users.odo59 = import ./home.nix;
                    }
                ];
            };

            home-laptop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {
                    inherit inputs;
                };

                modules = [
                    /home/odo59/.config/nixos/modules/config.nix
                    /home/odo59/.config/nixos/modules/home-laptop.nix
                    inputs.home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.extraSpecialArgs = {
                            inherit inputs;
                        };
                        home-manager.users.odo59 = import ./home.nix;
                    }
                ];
            };
        };
    };
}
