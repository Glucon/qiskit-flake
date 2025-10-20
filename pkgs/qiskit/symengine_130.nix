{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  gmp,
  flint,
  mpfr,
  libmpc,
  withShared ? true,
}:
stdenv.mkDerivation rec {
  pname = "symengine";
  version = "0.13.0";
  src = fetchFromGitHub {
    owner = "symengine";
    repo = "symengine";
    rev = "v${version}";
    hash = "sha256-hMTndwIXTqf3cxKZdnn38SFvZLEb48k1Lvm5/hW7U8k=";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [
    gmp
    flint
    mpfr
    libmpc
  ];

  postPatch = ''
    sed -i 's/cmake_minimum_required(VERSION [0-9.]*)/cmake_minimum_required(VERSION 3.5)/' CMakeLists.txt

    if [ -f cmake/SymEngineConfig.cmake.in ]; then
      sed -i 's/cmake_minimum_required(VERSION [0-9.]*)/cmake_minimum_required(VERSION 3.5)/g' cmake/SymEngineConfig.cmake.in
    fi
  '';

  cmakeFlags = [
    "-DWITH_FLINT=ON"
    "-DINTEGER_CLASS=flint"
    "-DWITH_SYMENGINE_THREAD_SAFE=yes"
    "-DWITH_MPC=yes"
    "-DBUILD_FOR_DISTRIBUTION=yes"
    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
  ]
  ++ lib.optionals (stdenv.hostPlatform.isDarwin && stdenv.hostPlatform.isAarch64) [
    "-DBUILD_TESTS=OFF"
  ]
  ++ lib.optionals withShared [
    "-DBUILD_SHARED_LIBS=ON"
  ];

  doCheck = true;

  meta = with lib; {
    description = "Fast symbolic manipulation library";
    homepage = "https://github.com/symengine/symengine";
    platforms = platforms.unix ++ platforms.windows;
    license = licenses.bsd3;
    maintainers = [ maintainers.costrouc ];
  };
}
