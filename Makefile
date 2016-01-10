prefix = ./install
instname = usr/
outputdir = ${prefix}/${instname}
archive = geda
xzarchive  = $(archive:%=%.tar.xz)
ziparchive = $(archive:%=%.zip)

libs = mingw-libs/libgcc_s_sjlj-1.dll

packages = libtool mingw-libgnurx libffi gmp libiconv libunistring gettext libatomic_ops gc jpeg zlib libpng tiff freetype pixman glib atk cairo pango gdk-pixbuf gtk+ hicolor-icon-theme guile geda-gaf gd pcb gerbv pkgconfig-wrapper

.PHONY: all install install-libs clean maintainer-clean ${packages}

# Main packages we want to compile
all: geda-gaf pcb gerbv


# Packages without dependencies are:
#   libtool
#   mingw-libgnurx
#   libiconv
#   libatomic_ops
#   jpeg
#   zlib
#   tiff
#   freetype
#   pixman
#   hicolor-icon-theme
#   gd

# Time stamps directory
.stamp:
	[ -e $@ ] || mkdir $@

# Build commands for all packages
${packages}: .stamp
	if [ -e ".stamp/$@" ]; then : ; \
	  else \
	  ./mpk source $@ && \
	  ./mpk build $@ && \
	  touch ".stamp/$@"; \
	  fi

# dependencies
gettext: libiconv
# libtool is a soft dependency
gmp: libtool
libffi: libtool
# libtool & libiconv are soft dependencies
libunistring: libtool libiconv
gc: libatomic_ops
libpng: zlib
glib: pkgconfig-wrapper zlib libffi gettext
atk: glib
cairo: libpng pixman freetype
# cairo is a soft dependency
# it must be built before pango
pango: glib cairo
gdk-pixbuf: glib tiff jpeg libpng
# hicolor-icon-theme is not required
gtk+: hicolor-icon-theme atk cairo pango gdk-pixbuf
guile: gmp libunistring libffi gc
geda-gaf: guile glib gtk+
#gtkglext: gtk+
# pcb needs tk to be installed on the build system
# NOTE: Now pcb is not dependent on gtkglext since it is compiled with the
#   "--disable-gl" option. For compiling with "--enable-gl" other additional
#   libraries are needed.
pcb: mingw-libgnurx gtk+ gd
gerbv: mingw-libgnurx gtk+

mingw-libs:
	[ -d $@ ] || mkdir $@

# NOTE: This recipe works only on Debian compatible systems. You may want to run
# 'sudo update-dlocatedb' before this.
mingw-libs/libgcc_s_sjlj-1.dll: mingw-libs
	cd $< && cp $$(dlocate libgcc_s_sjlj-1.dll|grep win32|cut -d' ' -f 2) .

install-libs: ${libs}
	cp $^ ./result/bin/

install: install-libs
	cp README.windows ./result/README
	cp pixbuf.bat ./result/bin/
	[ -e ${outputdir} ] && rm -rf ${outputdir}
	cp --preserve=timestamps ./result/ -r -L ${outputdir}

xz: ${xzarchive}
${xzarchive}: ${outputdir}
	tar -c $< | xz > $@

zip: ${ziparchive}
${ziparchive}:
	cd install/ && zip -r $@ ${instname}
	mv install/$@ .

# You can use, e.g. 'make packages=geda-gaf clean'
clean:
	for i in ${packages}; do ./mpk clean $$i; done
	for i in ${packages}; do rm -f .stamp/$$i; done

maintainer-clean: clean
	rm -rf result/*
