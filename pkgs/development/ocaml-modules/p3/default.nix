{ stdenv, fetchgit, ocaml, findlib }:

let version = "x.y.z"; in

stdenv.mkDerivation {
  name = "p3-${version}";

  src = fetchgit {
    url = https://github.com/tomjridge/p3.git;
    rev = "0e42a29";
    sha256 = "795b8bacbea102021ad4aaa819d578e58fd7d2041eba60e36482e04e01f81c32";
  };

  buildInputs = [ ocaml findlib ];

  configurePhase = "true"; 	# Skip configure

  createFindlibDestdir = true;

  meta = {
    homepage = http://batteries.forge.ocamlcore.org/;
    description = "OCaml Batteries Included";
    longDescription = ''
      A community-driven effort to standardize on an consistent, documented,
      and comprehensive development platform for the OCaml programming
      language.
    '';
    license = stdenv.lib.licenses.lgpl21Plus;
    platforms = ocaml.meta.platforms;
    maintainers = [
      stdenv.lib.maintainers.z77z
    ];
  };
}
