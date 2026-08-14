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
  } @ inputs: let
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
      "ethan-gti15" = {
        username = "ethang";
        system = "x86_64-linux";
        homeDirectory = "/home/ethang";
        type = "nixos";
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

    mkNixos = hostName: host:
      nixpkgs.lib.nixosSystem {
        system = host.system;

        specialArgs = {
          inherit inputs hostName host;
        };

        modules = [
          ./hosts/${hostName}/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs hostName host;
              };
              users.${host.username} = import ./home/${host.username}/home.nix;
            };
          }
        ];
      };
    nixosHosts = lib.filterAttrs (_hostName: host: host.type == "nixos") hosts;
    homeHosts = lib.filterAttrs (_hostName: host: host.type == "home") hosts;
  in {
    nixosConfigurations = lib.mapAttrs mkNixos nixosHosts;
    homeConfigurations =
      lib.mapAttrs'
      (
        hostName: host:
          lib.nameValuePair
          "${host.username}@${hostName}"
          (mkHome hostName host)
      )
      homeHosts;
  };
}
