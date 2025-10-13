{
  buildPythonPackage,
  fetchFromGitHub,
  # build-system
  setuptools,
  # Python Inputs
  numpy,
  qiskit,
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
    qiskit
    scipy
    numpy
  ];

  doCheck = false;
}
