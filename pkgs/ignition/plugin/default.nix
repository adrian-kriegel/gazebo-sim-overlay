{ lib, stdenv, fetchFromGitHub, fetchpatch, cmake, pkg-config
, majorVersion ? "2", version ? "2.0.2"
, srcHash ? "sha256-JHRa84uED+dqu0EHrVFTh6o7eiVpgPbTYqpv8vZtJM4="
, ignition-cmake, ignition-utils, ... }:

stdenv.mkDerivation rec {
  pname = "gz-plugin${majorVersion}";
  inherit version;

  src = fetchFromGitHub rec {
    name = "${rev}-source";
    owner = "gazebosim";
    repo = "gz-plugin";
    rev = "${pname}_${version}";
    hash = srcHash;
  };

  nativeBuildInputs = [ cmake ];
  # pkg-config is needed to use some CMake modules in this package
  propagatedBuildInputs = [ pkg-config ignition-cmake ignition-utils ];
  buildInputs = [ ignition-cmake ignition-utils ];

  meta = with lib; {
    homepage = "https://ignitionrobotics.org/libs/cmake";
    description = "Cross-platform C++ library for dynamically loading plugins.";
    license = licenses.asl20;
    maintainers = with maintainers; [ muellerbernd ];
    platforms = platforms.all;
  };
}
