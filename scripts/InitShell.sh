#!/bin/sh

if [ -f flake.nix ]; then
  exit 0
else
  
cat <<EOF > flake.nix
{
  description = "my project description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.\${system};
          nix-utils = with pkgs; [
            nil
            nixpkgs-fmt
          ];
          shell = pkgs.mkShell {
            nativeBuildInputs = with pkgs.buildPackages; [ $@ ] ++ nix-utils;
          };
        in
        {
          devShells.default = shell;
        }
      );
}
EOF
fi
