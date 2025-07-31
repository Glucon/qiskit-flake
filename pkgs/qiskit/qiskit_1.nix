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
, setuptools
, setuptools-rust
, ...
}:
buildPythonPackage rec {
  pname = "qiskit";
  version = "1.4.3";
  src = fetchFromGitHub {
    owner = "Qiskit";
    repo = pname;
    rev = version;
    hash = "sha256-Oaq83K9R5MxXlbHk31BK2bd9c+SVbg4uCTW1UOJa+w0=";
  };
  pyproject = true;
  build-system = [ setuptools ];
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
    hash = "sha256-EDvP0CZErC9z+SfiMPHrxYrbmmnui3f3bk0ptfOfca8=";
  };
  doCheck = false;
}

