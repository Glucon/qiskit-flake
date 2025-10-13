{
  fetchFromGitHub,
  rustPlatform,
  rustc,
  cargo,
  buildPythonPackage,
  rustworkx,
  numpy,
  scipy,
  dill,
  python-dateutil,
  stevedore,
  typing-extensions,
  symengine,
  setuptools,
  setuptools-rust,
  ...
}:
buildPythonPackage rec {
  pname = "qiskit";
  version = "2.2.1";
  src = fetchFromGitHub {
    owner = "Qiskit";
    repo = pname;
    rev = version;
    hash = "sha256-fEefk0pi4XytplYF0JlDijyxonu6KkYK+DH2VIPEau0=";
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
  nativeBuildInputs = [
    setuptools-rust
    rustc
    cargo
    rustPlatform.cargoSetupHook
  ];

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-2LpchfqSJGADvtg4F6NYJ1YKPhXk2u+6tNlSeKLv4wA=";
  };
  doCheck = false;
}
