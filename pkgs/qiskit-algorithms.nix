{
  buildPythonPackage,
  fetchFromGitHub,
  # build-system
  setuptools,
  # Python Inputs
  numpy,
  qiskit-1,
  scipy,
  ...
}:

buildPythonPackage rec {
  pname = "qiskit-algorithms";
  version = "0.4.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "qiskit-community";
    repo = pname;
    tag = version;
    hash = "sha256-qQ8UID43tc6ODUyocas12cbXEsVdP7/q4s/fkYrP4fc=";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    qiskit_1
    scipy
    numpy
  ];

  doCheck = false;
}
