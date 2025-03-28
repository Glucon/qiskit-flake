{ lib
, stdenv
, fetchFromGitHub
, cmake
, enableShared ? !stdenv.hostPlatform.isStatic
, # tests
  mpd
, openimageio
, fcitx5
, spdlog
,
}:

let
  generic =
    { version
    , hash
    , patches ? [ ]
    ,
    }:
    stdenv.mkDerivation {
      pname = "fmt";
      inherit version;

      outputs = [
        "out"
        "dev"
      ];

      src = fetchFromGitHub {
        owner = "fmtlib";
        repo = "fmt";
        rev = version;
        inherit hash;
      };

      inherit patches;

      nativeBuildInputs = [ cmake ];

      cmakeFlags = [ (lib.cmakeBool "BUILD_SHARED_LIBS" enableShared) ];

      doCheck = true;

      passthru.tests = {
        inherit
          mpd
          openimageio
          fcitx5
          spdlog
          ;
      };

      meta = with lib; {
        description = "Small, safe and fast formatting library";
        longDescription = ''
          fmt (formerly cppformat) is an open-source formatting library. It can be
          used as a fast and safe alternative to printf and IOStreams.
        '';
        homepage = "https://fmt.dev/";
        changelog = "https://github.com/fmtlib/fmt/blob/${version}/ChangeLog.rst";
        downloadPage = "https://github.com/fmtlib/fmt/";
        maintainers = [ maintainers.jdehaas ];
        license = licenses.mit;
        platforms = platforms.all;
      };
    };
in

generic {
  version = "8.1.1";
  hash = "sha256-leb2800CwdZMJRWF5b1Y9ocK0jXpOX/nwo95icDf308=";
}

