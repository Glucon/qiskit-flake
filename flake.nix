{
  description = "Qiskit Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.git-hooks.flakeModule inputs.treefmt-nix.flakeModule ];
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, lib, ... }:
        let
          mkPythonEnv = pythonVersion: (import ./python.nix {
            inherit pkgs pythonVersion;
          });
        in
        {

          legacyPackages.python3 = mkPythonEnv pkgs.python3;
          legacyPackages.python39 = mkPythonEnv pkgs.python39;
          legacyPackages.python310 = mkPythonEnv pkgs.python310;
          legacyPackages.python311 = mkPythonEnv pkgs.python311;
          legacyPackages.python312 = mkPythonEnv pkgs.python312;
          legacyPackages.python313 = mkPythonEnv pkgs.python313;

          devShells.default =
            pkgs.mkShell {
              inputsFrom = [ config.pre-commit.devShell config.treefmt.build.devShell ];
              buildInputs = [
                (self'.legacyPackages.python3.withPackages (p: with p; [ qiskit qiskit-aer ]))
              ];
            };

          pre-commit = {
            check.enable = true;
            settings.hooks = {
              nixpkgs-fmt.enable = true;
              shfmt = {
                enable = true;
                args = [ "-i" "2" ];
              };
              prettier = {
                enable = true;
                excludes = [ "flake.lock" ];
              };
            };
          };

          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixpkgs-fmt.enable = true;
              shfmt.enable = true;
              prettier.enable = true;
            };
            settings.global = {
              excludes = [ ];
            };
          };
        };
      flake = { };
    };
}
