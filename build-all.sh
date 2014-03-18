NEVERBUILD="
fontconfig
"

NOBUILD="
"

BUILD="
libtool
gmp
libiconv
libunistring
gettext
libatomic_ops
gc
libffi
guile

jpeg
zlib
libpng
tiff
expat
freetype
pixman
pkgconfig-wrapper
glib
atk
cairo
pango
gdk-pixbuf
gtk+
geda-gaf

mingw-libgnurx
gd
gtkglext
pcb
gerbv
"

fail()
{
  echo
  echo "=================="
  echo "Build failed."
  echo "=================="
  exit 1
}

succeed()
{
  echo
  echo "====================="
  echo "Build succeeded."
  echo "====================="
}

for D in $BUILD; do
  ./mpk source $D || fail
done

for D in $BUILD; do
  ./mpk build $D || fail
done

succeed

