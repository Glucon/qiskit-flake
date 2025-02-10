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
  version = "1.3.2";
  src = fetchFromGitHub {
    owner = "qiskit";
    repo = "Qiskit";
    rev = version;
    hash = "sha256-GrwrTUek921NEpn51+Pj/KJZExkeWokxFkd0CqrFjMo=";
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

  # cargoDeps = rustPlatform.fetchCargoVendor {
  # for fetchCargoVendor
  # https://github.com/NixOS/nixpkgs/issues/377558

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit pname version src;
    hash = "sha256-PyClKtoncJsHgvjK5aZFKLtUMhezFD5zkppew2XrBY0=";
  };
  doCheck = false;
}

