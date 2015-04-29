# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, HUnit, stm, testFramework, testFrameworkHunit }:

cabal.mkDerivation (self: {
  pname = "async";
  version = "2.0.1.6";
  sha256 = "06fzkqjliccxqiygms7v1xff3wlkg54n9xwzv7m1yxylkzlikjkz";
  buildDepends = [ stm ];
  testDepends = [ HUnit testFramework testFrameworkHunit ];
  jailbreak = true;
  meta = {
    homepage = "https://github.com/simonmar/async";
    description = "Run IO operations asynchronously and wait for their results";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
