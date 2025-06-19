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
  version = "2.1.0";
  src = fetchFromGitHub {
    owner = "qiskit";
    repo = "Qiskit";
    rev = version;
    hash = "sha256-2aPlm1IsJ10ixT4qnSTd0U4NpDHV+yYQv3+3SYML2kQ=";
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
    hash = "sha256-G1JC0Tur6MbNiCS8ACPDQ6eeeuZJRaCkgl/j9ne/sfg=";
  };
  doCheck = false;
}

