{ fetchFromGitHub
, cmake
, ninja
, blas
, buildPythonPackage
, setuptools
, scikit-build
, pybind11
, numpy
, scipy
, psutil
, qiskit
, nlohmann_json_3_1_1
, spdlog_1_9_2
, ...
}:
buildPythonPackage rec {
  pname = "qiskit-aer";
  version = "0.17.1";
  src = fetchFromGitHub {
    owner = "Qiskit";
    repo = "qiskit-aer";
    rev = "refs/tags/${version}";
    hash = "sha256-jvapuARJUHgAKFUzGb5MUft01LNefVIXtStJqFnCo90=";
  };
  dontUseCmakeConfigure = true;
  DISABLE_CONAN = true;
  buildInputs = [ spdlog_1_9_2 nlohmann_json_3_1_1 blas ];
  nativeBuildInputs = [ setuptools scikit-build cmake ninja pybind11 ];
  propagatedBuildInputs = [ numpy scipy psutil qiskit ];
  doCheck = false;
  patches = [ ];
}

