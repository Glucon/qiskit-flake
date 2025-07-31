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
  version = "2.1.1";
  src = fetchFromGitHub {
    owner = "Qiskit";
    repo = pname;
    rev = version;
    hash = "sha256-WHfsl/T4lmnvkGY7gF5PStilGq3G66TZG9oB1tKwuOQ=";
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
    hash = "sha256-MqHm2J+8xXFzm8/ob76hfNeQgTu0CiWrGCo+oXLPEuc=";
  };
  doCheck = false;
}
