{
  outputs = {
    self,
    nixpkgs,
  }: {
    packages.x86_64-linux.default = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
      pkgs.stdenv.mkDerivation {
        pname = "comp58";
        version = "1.0";
        src = ./.;
        buildInputs = [pkgs.faust2jack];
        buildPhase = "faust2jack ./comp58.dsp";
        installPhase = ''
          mkdir -p $out/bin
          cp comp58 $out/bin
        '';
      };
  };
}
