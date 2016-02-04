{ stdenv, fetchurl, makeWrapper, pkgconfig, cmake, fcitx, gtk3, isocodes, gnome3 }:

stdenv.mkDerivation rec {
  name = "fcitx-configtool-0.4.8";

  meta = with stdenv.lib; {
    description = "GTK-based config tool for Fcitx";
    license     = licenses.gpl2;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ cdepillabout ];
  };

  src = fetchurl {
    url = "http://download.fcitx-im.org/fcitx-configtool/${name}.tar.xz";
    sha256 = "1vaim0namw58bfafbvws1vgd4010p19zwqfbx6bd1zi5sgchdg0f";
  };

  buildInputs = [ makeWrapper fcitx cmake isocodes pkgconfig gtk3
    gnome3.defaultIconTheme ];

  preFixup = ''
    wrapProgram $out/bin/fcitx-config-gtk3 \
      --prefix XDG_DATA_DIRS : "$XDG_ICON_DIRS";
  '';
}

