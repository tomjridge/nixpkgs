# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, cleanUnions, transformers }:

cabal.mkDerivation (self: {
  pname = "elevator";
  version = "0.1.3";
  sha256 = "0z7rj70ilv4y95prfdj3fjlw4icr64d66lqgyr6jp28zxrxw1535";
  buildDepends = [ cleanUnions transformers ];
  meta = {
    homepage = "https://github.com/fumieval/elevator";
    description = "Immediately lifts to a desired level";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = with self.stdenv.lib.maintainers; [ fuuzetsu ];
  };
})
