# Qiskit-flake

This flake contains nix packages [qiskit](https://github.com/Qiskit/qiskit) and [qiskit-aer](https://github.com/Qiskit/qiskit-aer).

## Usage

### Use `nix develop`

To enter a development environment, run:

```shell
git clone https://github.com/Glucon/qiskit-flake.git
cd qiskit-flake
nix develop .
```

### Use [flake-parts](https://flake.parts/)

```nix
{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    qiskit-flake = {
      url = "github:Glucon/qiskit-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default =
          pkgs.mkShell {
            packages = [
              (inputs'.qiskit-flake.legacyPackages.python3Packages.withPackages (
                p: with p; [
                  qiskit
                  qiskit-aer
                ]
              )
              )
            ];
          };
      };
      flake = { };
    };
}
```
