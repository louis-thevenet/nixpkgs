{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  libpulseaudio,
}:
let
  pname = "rsmixer";
  version = "0.5.5";
in
rustPlatform.buildRustPackage {
  pname = pname;
  version = version;

  src = fetchFromGitHub {
    owner = "jantap";
    repo = pname;
    tag = "v${version}";
    hash = "sha256-HvmX3GCMExkQ74OGiYsDlsNfJk+i258A5seNy3e+wCw=";
  };
  useFetchCargoVendor = true;
  cargoHash = "sha256-AWrPjHzxS74nrzdC7OMsMPKe6YL8SLfYxBKqnksys/I=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libpulseaudio ];

  meta = {
    description = "TUI PulseAudio volume mixer";
    homepage = "https://github.com/jantap/rsmixer";
    license = lib.licenses.mit;
    mainProgram = "rsmixer";
    maintainers = with lib.maintainers; [ louis-thevenet ];
  };
}
