{ stdenv, fetchurl, pkgconfig, gtk, libpng, exiv2
, lcms, intltool, gettext, libchamplain, fbida
}:

stdenv.mkDerivation rec {
  name = "geeqie-${version}";
  version = "1.1"; # Don't upgrade to 1.2; see fee59b1235e658954b207ff6679264654c4708d2.

  src = fetchurl {
    url = "mirror://sourceforge/geeqie/${name}.tar.gz";
    sha256 = "1kzy39z9505xkayyx7rjj2wda76xy3ch1s5z35zn8yli54ffhi2m";
  };

  configureFlags = [ "--enable-gps" ];

  buildInputs = [
    pkgconfig gtk libpng exiv2 lcms intltool gettext
    #libchamplain
  ];

  postInstall = ''
    # Allow geeqie to find exiv2 and exiftran, necessary to
    # losslessly rotate JPEG images.
    sed -i $out/lib/geeqie/geeqie-rotate \
        -e '1 a export PATH=${exiv2}/bin:${fbida}/bin:$PATH'
  '';

  meta = with stdenv.lib; {
    description = "Lightweight GTK+ based image viewer";

    longDescription =
      ''
        Geeqie is a lightweight GTK+ based image viewer for Unix like
        operating systems.  It features: EXIF, IPTC and XMP metadata
        browsing and editing interoperability; easy integration with other
        software; geeqie works on files and directories, there is no need to
        import images; fast preview for many raw image formats; tools for
        image comparison, sorting and managing photo collection.  Geeqie was
        initially based on GQview.
      '';

    license = licenses.gpl2Plus;

    homepage = http://geeqie.sourceforge.net;

    maintainers = with maintainers; [ pSub ];
    platforms = platforms.gnu;
  };
}
