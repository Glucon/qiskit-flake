{
  buildPythonPackage,
  fetchFromGitHub,
  # build-system
  setuptools,
  # Python Inputs
  numpy,
  psutil,
  qiskit_1,
  scipy,
  scikit-learn,
  dill,
  ...
}:

buildPythonPackage rec {
  pname = "qiskit-machine-learning";
  version = "0.8.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "qiskit-community";
    repo = pname;
    tag = version;
    hash = "sha256-XnLCejK6m8p/OC5gKCoP1UXVblISChu3lKF8BnrnRbk=";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    qiskit_1
    scipy
    numpy
    psutil
    scikit-learn
    dill
  ];

  doCheck = false;
}
