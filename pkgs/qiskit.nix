{ fetchFromGitHub
, rustPlatform
, rustc
, cargo
, buildPythonPackage
, rustworkx
, numpy
, scipy
, dill
, python-dateutil
, stevedore
, typing-extensions
, symengine
, setuptools-rust
, ...
}:
buildPythonPackage rec {
  pname = "qiskit";
  version = "2.0.1";
  src = fetchFromGitHub {
    owner = "qiskit";
    repo = "Qiskit";
    rev = version;
    hash = "sha256-9AsGEc60JgekomDxNZY4wlTo+y/7I2YIKT96Iu6qa/k=";
  };
  propagatedBuildInputs = [
    rustworkx
    numpy
    scipy
    dill
    python-dateutil
    stevedore
    typing-extensions
    symengine
  ];
  nativeBuildInputs = [ setuptools-rust rustc cargo rustPlatform.cargoSetupHook ];

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-esF0uwm7J27P5rR9IR1cZ2F6Bf0sHSQ0fJzZf0UcIZE=";
  };
  doCheck = false;
}

