{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = [
    pkgs.elmPackages.elm
    pkgs.elmPackages.elm-format
    pkgs.elmPackages.elm-test
    pkgs.elmPackages.elm-review
    pkgs.nodejs_20
    pkgs.git
    pkgs.bash
    pkgs.findutils
    pkgs.gnused
  ];
  shellHook = ''
    export ELM_OPEN_API_CLI_DEVSHELL_ACTIVE=1
  '';
}
