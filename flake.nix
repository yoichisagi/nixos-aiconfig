{
  description = "NixOS Flake configuration for ThinkPad T470s with Hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware }:
    let
      system = "x86_64-linux";
      username = "shousuke";
      hostname = "komi";
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit username hostname; };
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t470s
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home/home.nix;
            home-manager.extraSpecialArgs = { inherit username; };
          }
        ];
      };

      devShells.${system}.default = nixpkgs.mkShell {
        buildInputs = with nixpkgs; [
          git
          nixpkgs-fmt
        ];
      };
    };
}
