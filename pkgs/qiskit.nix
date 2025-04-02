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
  version = "2.0.0";
  src = fetchFromGitHub {
    owner = "qiskit";
    repo = "Qiskit";
    rev = version;
    hash = "sha256-RRewZ9ET1Nbnmg7vi2ij5uulatwpDmaTOJaFmo7ZyN4=";
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
    hash = "sha256-axt873O4vukF25MHTITBo+eAWsOZRuV6PS/EiBoK5Xs=";
  };
  doCheck = false;
}

