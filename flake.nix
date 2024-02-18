{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs: {
    nixosConfigurations = {
      LHdesktop01 = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/LHdesktop01
        ];
        specialArgs = {
          inherit inputs; #inputs = inputs と等しい
        };
      };
    };

    homeConfigurations = {
      desktop = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true; # プロプライエタリなパッケージを許可
        };
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./home/desktop
        ];
      };
    };
  };
}
