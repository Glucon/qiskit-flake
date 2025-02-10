{ stdenv
, fetchFromGitHub
, cmake
, hostPlatform
, lib
,
}:
stdenv.mkDerivation rec {
  name = "nlohmann_json-${version}";
  version = "3.1.1";

  src = fetchFromGitHub {
    owner = "nlohmann";
    repo = "json";
    rev = "v${version}";
    hash = "sha256-xpnYwxtEuNKpndfR7reiwVjOSq0iLD8/mIL1bbePvWg=";
  };

  nativeBuildInputs = [ cmake ];

  enableParallelBuilding = true;

  cmakeFlags =
    [
      "-DBuildTests=${
        if doCheck
        then "ON"
        else "OFF"
      }"
    ]
    ++ lib.optionals (hostPlatform.libc == "msvcrt") [
      "-DCMAKE_SYSTEM_NAME=Windows"
    ];

  doCheck = false;

  meta = with lib; {
    description = "Header only C++ library for the JSON file format";
    homepage = "https://github.com/nlohmann/json";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
