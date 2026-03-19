{
  description = "ethang's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }@inputs: let
      lib = nixpkgs.lib; 

      hosts = {
        nixos = {
          username = "ethang";
          system = "x86_64-linux";
          homeDirectory = "/home/ethang";
          type = "nixos";
        };

        "ethan-ser9" = {
          username = "ethan";
          system = "x86_64-linux";
          homeDirectory = "/home/ethan";
          type = "home";
        };

      };
      
      mkPkgs = system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
      };

      mkHome = hostName: host:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs host.system;

          extraSpecialArgs = {
            inherit inputs hostName host;
          };

          modules = [
            ./home/${host.username}/home.nix
            {
              home.username = host.username;
              home.homeDirectory = host.homeDirectory;
              home.stateVersion = "25.11";
            }
          ];
        };
  in {

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = hosts.nixos.system;

          specialArgs = {
            inherit inputs;
            hostName = "nixos";
            host = hosts.nixos;
          };

          modules = [
            ./hosts/nixos/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                hostName = "nixos";
                host = hosts.nixos;
              };
              home-manager.users.${hosts.nixos.username} =
                import ./home/${hosts.nixos.username}/home.nix;
            }
          ];
        };
      };

      homeConfigurations = {
        "ethan@ethan-ser9" = mkHome "ethan-ser9" hosts."ethan-ser9";
      };
  };
}
