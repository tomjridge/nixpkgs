# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, hxt, mtl }:

cabal.mkDerivation (self: {
  pname = "hxt-pickle-utils";
  version = "0.1.0.2";
  sha256 = "06v4935lljcyyx4a5v0z4id3fz4v28aghsrzr94k6diibpnwcdz2";
  buildDepends = [ hxt mtl ];
  meta = {
    homepage = "https://github.com/silkapp/hxt-pickle-utils";
    description = "Utility functions for using HXT picklers";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = with self.stdenv.lib.maintainers; [ aycanirican ];
  };
})
