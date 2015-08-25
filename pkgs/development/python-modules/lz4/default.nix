{stdenv, fetchgit, python, setuptools, makeWrapper}:

stdenv.mkDerivation rec {
  name = "python-lz4";
  src = fetchgit {
    url = "https://github.com/steeve/python-lz4";
    rev = "8ac9cf9df8fb8d51f40a3065fa538f8df1c8a62a";
    sha256 = "57b7aa4b9fd5d186d8e70b7007fae0c920b0e59cd3569784ddea892f1034f4fa";
  };

  buildInputs = [python setuptools makeWrapper];
  buildPhase = "python ./setup.py build";
  installPhase = ''
  # from mpi4py.default.nix
    mkdir -p "$out/lib/${python.libPrefix}/site-packages"
    export PYTHONPATH="$out/lib/${python.libPrefix}/site-packages:$PYTHONPATH"

    ${python}/bin/${python.executable} setup.py install \
      --install-lib=$out/lib/${python.libPrefix}/site-packages \
      --prefix="$out"



#     python ./setup.py install --prefix="$out" || exit 1
# 
#     export PYTHONPATH="$PYTHONPATH:$out/lib/python2.7/site-packages"
#     for i in "$out/bin/"*
#     do
#       # FIXME: We're assuming Python 2.7.
#       wrapProgram "$i" --prefix PYTHONPATH :  \
#        "$out/lib/python2.7/site-packages" ||  \
#         exit 2
#     done
  '';

  meta = {
    description = "Python lz4 bindings";
    homepage = https://github.com/steeve/python-lz4;
  };
}
