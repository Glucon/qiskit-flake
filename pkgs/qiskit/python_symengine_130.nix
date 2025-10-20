{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  cython,
  cmake,
  symengine_130,
  pytest,
  sympy,
  setuptools,
  numpy,
}:
buildPythonPackage rec {
  pname = "symengine";
  version = "0.13.0";
  build-system = [ setuptools ];
  pyproject = true;

  src = fetchFromGitHub {
    owner = "symengine";
    repo = "symengine.py";
    tag = "v${version}";
    hash = "sha256-PJUzA86SGCnDpqU9j/dr3PlM9inyi8SQX0HGqPQ9wQw=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace-fail "'cython>=0.29.24'" "'cython'"

    sed -i '1s/cmake_minimum_required(VERSION [0-9.]*)/cmake_minimum_required(VERSION 3.5)/' CMakeLists.txt

    export PATH=${cython}/bin:$PATH
  '';

  dontUseCmakeConfigure = true;

  nativeBuildInputs = [
    cmake
    cython
    numpy
  ];
  buildInputs = [ symengine_130 ];

  preBuild = ''
    export SymEngine_DIR="${symengine_130}"
    export CMAKE_PREFIX_PATH="${symengine_130}:${symengine_130}/lib/cmake:$CMAKE_PREFIX_PATH"
  '';

  # nativeCheckInputs = [
  #   pytest
  #   sympy
  # ];

  checkPhase = false;

  meta = with lib; {
    description = "Python library providing wrappers to SymEngine";
    homepage = "https://github.com/symengine/symengine.py";
    license = licenses.mit;
    maintainers = [ ];
  };
}
