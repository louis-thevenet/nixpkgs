{
  lib,
  stdenv,
  fetchFromGitHub,
  pam,
  bison,
  flex,
  systemdLibs,
  autoreconfHook,
}:

stdenv.mkDerivation rec {
  pname = "libcgroup";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "libcgroup";
    repo = "libcgroup";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-kWW9ID/eYZH0O/Ge8pf3Cso4yu644R5EiQFYfZMcizs=";
  };

  nativeBuildInputs = [
    autoreconfHook
    bison
    flex
  ];
  buildInputs = [
    pam
    systemdLibs
  ];

  postPatch = ''
    substituteInPlace src/tools/Makefile.am \
      --replace 'chmod u+s' 'chmod +x'
  '';

  meta = {
    description = "Library and tools to manage Linux cgroups";
    homepage = "https://github.com/libcgroup/libcgroup";
    license = lib.licenses.lgpl2;
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.thoughtpolice ];
  };
}
