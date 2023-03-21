{
  description = "Flake for development";
  inputs.nixpkgs.url = "nixpkgs/nixos-21.11";

  outputs = { self, nixpkgs }: {
    devShells =
      let
        supportedSystems = [
          "x86_64-linux"
          "x86_64-darwin"
          "aarch64-linux"
          "aarch64-darwin"
        ];
        forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      in
      forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = [
              pkgs.bashInteractive
              pkgs.elmPackages.elm
              pkgs.elmPackages.elm-format
              pkgs.elmPackages.elm-test
              pkgs.elmPackages.elm-review
              pkgs.nodejs-18_x
              pkgs.git
            ];
          };
        }
      );
  };
}
