{ pkgs, pythonVersion }:
let
  fmt_8 = pkgs.callPackage ./pkgs/fmt_8.nix { };
  spdlog_1_9_2 = pkgs.callPackage ./pkgs/spdlog_1_9_2 { inherit fmt_8; };
  nlohmann_json_3_1_1 = pkgs.callPackage ./pkgs/nlohmann_json_3_1_1.nix { };
  pythonEnv = pythonVersion.override {
    packageOverrides = self: super: {
      qiskit = self.callPackage ./pkgs/qiskit.nix { };
      qiskit_1 = self.callPackage ./pkgs/qiskit_1.nix { };
      qiskit-aer = self.callPackage ./pkgs/qiskit-aer.nix {
        inherit spdlog_1_9_2 nlohmann_json_3_1_1;
      };
      qiskit-machine-learning = self.callPackage ./pkgs/qiskit-machine-learning.nix { qiskit_1 = self.qiskit_1; };
      qiskit-algorithms = self.callPackage ./pkgs/qiskit-algorithms.nix { qiskit_1 = self.qiskit_1; };
      qiskit-nature = self.callPackage ./pkgs/qiskit-nature.nix { qiskit = self.qiskit_1; };
    };
  };
in
pythonEnv

