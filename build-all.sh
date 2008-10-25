NEVERBUILD="
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
fontconfig
pixman
glib
atk
cairo
pango
gtk+
libtool
gmp
guile
gd
pcb
libgeda
geda-symbols
geda-gschem
geda-gnetlist
geda-gattrib
geda-gsymcheck
geda-utils
geda-docs
geda-examples
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

