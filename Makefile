prefix = ./install
instname = usr/
outputdir = ${prefix}/${instname}

mingw-libs = mingw-libs/libgcc_s_sjlj-1.dll

packages = libtool mingw-libgnurx libffi gmp libiconv libunistring gettext libatomic_ops gc jpeg zlib libpng tiff freetype pixman glib atk cairo pango gdk-pixbuf gtk+ guile geda-gaf gd gtkglext pcb gerbv pkgconfig-wrapper

.PHONY: install install-libs clean maintainer-clean
install-libs: ${mingw-libs}
	cp $^ ./result/bin/

install: install-libs
	[ -e ${outputdir} ] && rm -rf ${outputdir}
	cp --preserve=timestamps ./result/ -r -L ${outputdir}

clean:
	for i in ${packages}; do ./mpk clean $$i; done

maintainer-clean: clean
	rm -rf result/*
