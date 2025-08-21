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
  version = "2.1.2";
  src = fetchFromGitHub {
    owner = "Qiskit";
    repo = pname;
    rev = version;
    hash = "sha256-9/Z9wFAgSjC+3FsfUz9zwqXEU8EBB9UJdXXrf+kvj6o=";
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
    hash = "sha256-xVQmOBn7rGVa2Ze71kRn9j4WnKh0aMTKB965ZfCpqkQ=";
  };
  doCheck = false;
}
