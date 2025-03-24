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
  version = "1.4.2";
  src = fetchFromGitHub {
    owner = "qiskit";
    repo = "Qiskit";
    rev = version;
    hash = "sha256-R9baj15eHyAc5rNx7fixTJrL8mhaDJDceE/00n55heU=";
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
    hash = "sha256-BEkiGuVU00CxTdTm1p0cjtX63xczrSiJ+1LsF4vR6Ho=";
  };
  doCheck = false;
}

