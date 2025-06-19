{ buildPythonPackage
, fetchFromGitHub
, # build-system
  setuptools
  # Python Inputs
, numpy
, qiskit_1
, scipy
, ...
}:

buildPythonPackage rec {
  pname = "qiskit-algorithms";
  version = "0.3.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "qiskit-community";
    repo = pname;
    tag = version;
    hash = "";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    qiskit_1
    scipy
    numpy
  ];

  doCheck = false;
}
