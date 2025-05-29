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
  version = "2.0.2";
  src = fetchFromGitHub {
    owner = "qiskit";
    repo = "Qiskit";
    rev = version;
    hash = "sha256-xEDhQWM5jOfNUQOmrfxy2whI9nFk/5olMo1KNHlTzC8=";
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
    hash = "sha256-H1ZhG4nrxd7ToLnaMwXHIuMGeZ+DLj0TtaeofU5/z5U=";
  };
  doCheck = false;
}

