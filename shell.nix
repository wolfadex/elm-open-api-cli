{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  buildInputs = [
    pkgs.elmPackages.elm
    pkgs.elmPackages.elm-format
    pkgs.elmPackages.elm-test-rs
    pkgs.elmPackages.elm-review
    pkgs.nodejs-18_x
    pkgs.git
    pkgs.bash
  ];
}
