{ pkgs, pythonVersion }:

let
  fmt_8 = pkgs.callPackage ./pkgs/fmt_8.nix { };
  spdlog_1_9_2 = pkgs.callPackage ./pkgs/spdlog_1_9_2 { inherit fmt_8; };
  nlohmann_json_3_1_1 = pkgs.callPackage ./pkgs/nlohmann_json_3_1_1.nix { };
  pythonEnv = pythonVersion.override {
    packageOverrides = pyfinal: pyprev: {
      qiskit = pyfinal.callPackage ./pkgs/qiskit.nix { };
      qiskit-aer = pyfinal.callPackage ./pkgs/qiskit-aer.nix {
        inherit spdlog_1_9_2 nlohmann_json_3_1_1;
      };
      qiskit-machine-learning = pyfinal.callPackage ./pkgs/qiskit-machine-learning.nix { };
    };
  };
in
pythonEnv

