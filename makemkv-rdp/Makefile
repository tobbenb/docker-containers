
ARCH=$(shell uname -m)
DESTDIR=
PREFIX=/usr

ifeq ($(ARCH),i586)
ARCH=i386
ARCH_OK=1
endif

ifeq ($(ARCH),i686)
ARCH=i386
ARCH_OK=1
endif

ifeq ($(ARCH),x86_64)
ARCH=amd64
ARCH_OK=1
endif

ifneq ($(ARCH_OK),1)
$(error MakeMKV is currently not available for architecture $(ARCH))
endif

all: tmp/eula_accepted
	@echo "type \"sudo make install\" to install"

clean:
	-rm -rf tmp

tmp/eula_accepted:
	@mkdir -p tmp
#	@/bin/bash src/ask_eula.sh src/eula_en_linux.txt
	@echo accepted > $@

install: tmp/eula_accepted bin/$(ARCH)/makemkvcon
	rm -f $(DESTDIR)$(PREFIX)/bin/makemkvcon
	rm -f $(DESTDIR)$(PREFIX)/bin/mmdtsdec
	rm -f $(DESTDIR)$(PREFIX)/share/MakeMKV/*.mo.gz
	install -d $(DESTDIR)$(PREFIX)/share/MakeMKV
	install -d $(DESTDIR)$(PREFIX)/bin
	install -t $(DESTDIR)$(PREFIX)/bin bin/$(ARCH)/makemkvcon
	install -t $(DESTDIR)$(PREFIX)/bin bin/i386/mmdtsdec
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/default.mmcp.xml
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/flac.mmcp.xml
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/wdtv.mmcp.xml
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/aac-stereo.mmcp.xml
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_deu.mo.gz
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_jpn.mo.gz
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_spa.mo.gz
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_ptb.mo.gz
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_dut.mo.gz
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_swe.mo.gz
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_nor.mo.gz
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_ita.mo.gz
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_chi.mo.gz
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_pol.mo.gz
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_dan.mo.gz
	install -m 644 -t $(DESTDIR)$(PREFIX)/share/MakeMKV src/share/makemkv_fra.mo.gz

