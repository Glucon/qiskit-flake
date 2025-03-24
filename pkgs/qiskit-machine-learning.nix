{ buildPythonPackage
, fetchFromGitHub
, # build-system
  setuptools
  # Python Inputs
, numpy
, psutil
, qiskit
, scipy
, scikit-learn
, dill
, ...
}:

buildPythonPackage rec {
  pname = "qiskit-machine-learning";
  version = "0.8.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "qiskit";
    repo = pname;
    tag = version;
    hash = "sha256-dvGUtB7R44B+DYZKl4R2Q0GdvLTjVKWD0KmuyCoaOSc=";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    qiskit
    scipy
    numpy
    psutil
    scikit-learn
    dill
  ];

  doCheck = false;
}
