{
  buildPythonPackage,
  fetchFromGitHub,
  # build-system
  setuptools,
  # Python Inputs
  qiskit_1,
  qiskit-algorithms,
  scipy,
  numpy,
  h5py,
  rustworkx,
  psutil,
  ...
}:

buildPythonPackage rec {
  pname = "qiskit-nature";
  version = "0.7.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "qiskit-community";
    repo = pname;
    tag = version;
    hash = "sha256-SVzg3McB885RMyAp90Kr6/iVKw3Su9ucTob2jBckBo0=";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    qiskit_1
    qiskit-algorithms
    scipy
    numpy
    h5py
    rustworkx
    psutil
  ];

  doCheck = false;
}
