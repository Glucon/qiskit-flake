{
  fetchFromGitHub,
  cmake,
  ninja,
  blas,
  buildPythonPackage,
  setuptools,
  scikit-build,
  pybind11,
  numpy,
  scipy,
  psutil,
  qiskit_1,
  nlohmann_json,
  spdlog,
  # nlohmann_json_3_1_1,
  # spdlog_1_9_2,
  ...
}:
buildPythonPackage rec {
  pname = "qiskit-aer";
  version = "0.17.2";
  src = fetchFromGitHub {
    owner = "Qiskit";
    repo = pname;
    rev = version;
    hash = "sha256-aVmGoLMnDjV3iB9s4tvcL62zKvH/p70mqeGsxHzi3nc=";
  };
  pyproject = true;
  build-system = [ setuptools ];
  patches = [
    ./remove_canon.patch
  ];
  dontUseCmakeConfigure = true;
  DISABLE_CONAN = true;
  buildInputs = [
    spdlog
    nlohmann_json
    # spdlog_1_9_2
    # nlohmann_json_3_1_1
    blas
  ];
  nativeBuildInputs = [
    scikit-build
    cmake
    ninja
    pybind11
  ];
  propagatedBuildInputs = [
    numpy
    scipy
    psutil
    qiskit_1
  ];
  doCheck = false;
}
