NEVERBUILD="
fontconfig
"

NOBUILD="
"

BUILD="
libiconv
gettext
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
libtool
gmp
mingw-libgnurx
guile
gd
pcb
geda-gaf
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

