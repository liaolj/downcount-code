APP_NAME=downcount
VERSION=0.1
TMP_DIR=/tmp/$(APP_NAME)
INSTALLDIR=${DESTDIR}/usr

# run with "INSTALLDIR=foo make install" to change installation location

all:

clean:
	rm -rf pkg

install: ${INSTALLDIR}/bin/downcount

${INSTALLDIR}/bin/downcount:
	mkdir -p ${INSTALLDIR}/bin
	cp downcount ${INSTALLDIR}/bin/

uninstall:
	rm ${INSTALLDIR}/bin/downcount

pkg-all: pkg-src

pkg-src:
	mkdir -p pkg
	rm -f pkg/$(APP_NAME)-*.tar.bz2
	- rm -rf $(TMP_DIR)
	mkdir -p $(TMP_DIR)
	git archive --format=tar --prefix=$(APP_NAME)-$(VERSION)/ master > pkg/$(APP_NAME)-$(VERSION).tar
	# To package the uncommitted code:
	#tar -cf pkg/$(APP_NAME)-$(VERSION).tar --transform 's,^\.,$(APP_NAME)-$(VERSION),' --exclude .git --exclude pkg --exclude '.*.swp' -v --show-transformed-names .
	bzip2 pkg/$(APP_NAME)-$(VERSION).tar


