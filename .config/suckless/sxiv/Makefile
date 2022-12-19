version = 26

srcdir = .
VPATH = $(srcdir)

PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

# autoreload backend: inotify/nop
AUTORELOAD = inotify

# enable features requiring giflib (-lgif)
HAVE_GIFLIB = 1

# enable features requiring libexif (-lexif)
HAVE_LIBEXIF = 1

# Uncomment to enable the alpha patch / ALPHA_PATCH
#xrender = -lXrender

# Uncomment to enable SVG support / SVG_IMAGE_SUPPORT_PATCH
svglibs = `pkg-config --cflags --libs librsvg-2.0 cairo`

# Uncomment to enable WebP support / WEBP_IMAGE_SUPPORT_PATCH
webplibs = -lwebpdemux -lwebp

# Uncomment to enable libcurl support / LIBCURL_PATCH
#curllibs = -lcurl
#curlobjs = url.o

cflags = -std=c99 -Wall -pedantic $(CFLAGS)
cppflags = -I. $(CPPFLAGS) -D_XOPEN_SOURCE=700 \
  -DHAVE_GIFLIB=$(HAVE_GIFLIB) -DHAVE_LIBEXIF=$(HAVE_LIBEXIF) \
  -I/usr/include/freetype2 -I$(PREFIX)/include/freetype2 $(svglibs)

lib_exif_0 =
lib_exif_1 = -lexif
lib_gif_0 =
lib_gif_1 = -lgif
ldlibs = $(LDLIBS) -lImlib2 -lX11 -lXft -lfontconfig \
  $(lib_exif_$(HAVE_LIBEXIF)) $(lib_gif_$(HAVE_GIFLIB)) $(webplibs) $(curllibs) $(xrender)

objs = autoreload_$(AUTORELOAD).o commands.o image.o main.o options.o \
  thumbs.o util.o window.o $(curlobjs)

all: sxiv

.PHONY: all clean install uninstall
.SUFFIXES:
.SUFFIXES: .c .o
$(V).SILENT:

sxiv: $(objs)
	@echo "LINK $@"
	$(CC) $(LDFLAGS) -o $@ $(objs) $(ldlibs) $(svglibs)

$(objs): Makefile sxiv.h commands.lst config.h patches.h
options.o: version.h
window.o: icon/data.h

.c.o:
	@echo "CC $@"
	$(CC) $(cflags) $(cppflags) -c -o $@ $<

config.h:
	@echo "GEN $@"
	cp $(srcdir)/config.def.h $@

patches.h:
	@echo "GEN $@"
	cp $(srcdir)/patches.def.h $@

version.h: Makefile .git/index
	@echo "GEN $@"
	v="$$(cd $(srcdir); git describe 2>/dev/null)"; \
	echo "#define VERSION \"$${v:-$(version)}\"" >$@

.git/index:

clean:
	rm -f *.o sxiv

install: all
	@echo "INSTALL bin/sxiv"
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp sxiv $(DESTDIR)$(PREFIX)/bin/
	chmod 755 $(DESTDIR)$(PREFIX)/bin/sxiv
	@echo "INSTALL sxiv.1"
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s!PREFIX!$(PREFIX)!g; s!VERSION!$(version)!g" sxiv.1 \
		>$(DESTDIR)$(MANPREFIX)/man1/sxiv.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/sxiv.1
	@echo "INSTALL share/sxiv/"
	mkdir -p $(DESTDIR)$(PREFIX)/share/sxiv/exec
	cp exec/* $(DESTDIR)$(PREFIX)/share/sxiv/exec/
	chmod 755 $(DESTDIR)$(PREFIX)/share/sxiv/exec/*

uninstall:
	@echo "REMOVE bin/sxiv"
	rm -f $(DESTDIR)$(PREFIX)/bin/sxiv
	@echo "REMOVE sxiv.1"
	rm -f $(DESTDIR)$(MANPREFIX)/man1/sxiv.1
	@echo "REMOVE share/sxiv/"
	rm -rf $(DESTDIR)$(PREFIX)/share/sxiv

