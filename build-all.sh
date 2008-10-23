NEVERBUILD="
fontconfig
freetype
expat
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
pixman
glib
atk
cairo
pango
gtk+
libtool
gmp
guile
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
  ./mpk build $D || fail
done

succeed

