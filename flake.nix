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
          pyVersions = [ "python3" "python39" "python310" "python311" "python312" "python313" "python314" ];
          pythonUse = "python3";
        in
        {
          legacyPackages = lib.genAttrs pyVersions (v: mkPythonEnv pkgs.${v});

          packages.default = self'.legacyPackages.${pythonUse}.pkgs.qiskit;
          packages.qiskit = self'.legacyPackages.${pythonUse}.pkgs.qiskit;
          packages.qiskit_1 = self'.legacyPackages.${pythonUse}.pkgs.qiskit_1;
          packages.qiskit-aer = self'.legacyPackages.${pythonUse}.pkgs.qiskit-aer;
          packages.qiskit-machine-learning = self'.legacyPackages.${pythonUse}.pkgs.qiskit-machine-learning;
          packages.qiskit-algorithms = self'.legacyPackages.${pythonUse}.pkgs.qiskit-algorithms;

          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.pre-commit.devShell config.treefmt.build.devShell ];
            buildInputs = [
              (self'.legacyPackages.${pythonUse}.withPackages (p: with p; [
                qiskit
                qiskit-aer
              ]))
            ] ++ (with pkgs; [
              just
            ]);
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
