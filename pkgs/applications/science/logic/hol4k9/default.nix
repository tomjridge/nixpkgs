{stdenv, fetchurl, polyml, graphviz, fontconfig, liberation_ttf,
 experimentalKernel ? true}:

let
  pname = "hol4";
  version = "k.9";
  holsubdir = "hol-kananaskis-9";
  kernelFlag = if experimentalKernel then "-expk" else "-stdknl";
in

stdenv.mkDerivation {
  name = "${pname}-${version}";

  # http://downloads.sourceforge.net/project/hol/hol/kananaskis-9/kananaskis-9.tar.gz?r=http%3A%2F%2Fhol.sourceforge.net%2FInstallKananaskis.html&ts=1391508894&use_mirror=garr

  src = fetchurl {
    url = mirror://sourceforge/hol/hol/kananaskis-9/kananaskis-9.tar.gz;
    sha256 = "956061c207fcaa7836ae5e8bf379a69e2932e25ccf41d3321c53693e909a9633";
  };

  buildInputs = [polyml graphviz fontconfig liberation_ttf];

  buildCommand = ''

    mkdir chroot-fontconfig
    cat ${fontconfig}/etc/fonts/fonts.conf > chroot-fontconfig/fonts.conf
    sed -e 's@</fontconfig>@@' -i chroot-fontconfig/fonts.conf
    echo "<dir>${liberation_ttf}</dir>" >> chroot-fontconfig/fonts.conf
    echo "</fontconfig>" >> chroot-fontconfig/fonts.conf

    export FONTCONFIG_FILE=$(pwd)/chroot-fontconfig/fonts.conf

    mkdir -p "$out/src"
    cd  "$out/src"

    tar -xzf "$src"
    cd ${holsubdir}

    substituteInPlace tools/Holmake/Holmake_types.sml \
      --replace "\"/bin/mv\"" "\"mv\"" \
      --replace "\"/bin/cp\"" "\"cp\""

    for f in tools/buildutils.sml help/src-sml/DOT;
    do
      substituteInPlace $f --replace "\"/usr/bin/dot\"" "\"${graphviz}/bin/dot\""
    done

    #sed -ie "/compute/,999 d" tools/build-sequence # for testing

    poly < tools/smart-configure.sml

    bin/build ${kernelFlag} -symlink

    mkdir -p "$out/bin"
    ln -st $out/bin  "$out/src/${holsubdir}/bin/"*
    # ln -s $out/src/hol4.${version}/bin $out/bin
  '';

  meta = {
    description = "Interactive theorem prover based on Higher-Order Logic";
    longDescription = ''
      HOL4 is the latest version of the HOL interactive proof
      assistant for higher order logic: a programming environment in
      which theorems can be proved and proof tools
      implemented. Built-in decision procedures and theorem provers
      can automatically establish many simple theorems (users may have
      to prove the hard theorems themselves!) An oracle mechanism
      gives access to external programs such as SMT and BDD
      engines. HOL4 is particularly suitable as a platform for
      implementing combinations of deduction, execution and property
      checking.
    '';
    homepage = "http://hol.sourceforge.net/";
    license = "BSD";
  };
}
