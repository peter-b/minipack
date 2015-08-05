prefix = ./install
instname = usr/
outputdir = ${prefix}/${instname}

mingw-libs = mingw-libs/libgcc_s_sjlj-1.dll

.PHONY: install install-libs
install-libs: ${mingw-libs}
	cp $^ ./result/bin/

install: install-libs
	[ -e ${outputdir} ] && rm -rf ${outputdir}
	cp --preserve=timestamps ./result/ -r -L ${outputdir}
