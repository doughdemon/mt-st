CFLAGS?=  -Wall -O2
SBINDIR= $(DESTDIR)/sbin
BINDIR=  $(DESTDIR)/bin
USRBINDIR= $(DESTDIR)/usr/bin
MANDIR= $(DESTDIR)/usr/share/man

MTDIR=$(BINDIR)

PROGS=mt stinit

all:	$(PROGS)

%: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $<

install: $(PROGS)
	install -d $(MTDIR) $(MANDIR) $(SBINDIR)
	install -s mt $(MTDIR)
	install -c -m 444 mt.1 $(MANDIR)/man1
	(if [ -f $(MANDIR)/man1/mt.1.gz ] ; then \
	  rm -f $(MANDIR)/man1/mt.1.gz; gzip $(MANDIR)/man1/mt.1; fi)
	install -s stinit $(SBINDIR)
	install -c -m 444 stinit.8 $(MANDIR)/man8
	(if [ -f $(MANDIR)/man8/stinit.8.gz ] ; then \
	  rm -f $(MANDIR)/man8/stinit.8.gz; gzip $(MANDIR)/man8/stinit.8; fi)

dist:	clean
	(mydir=`basename \`pwd\``;\
	cd .. && tar cvvf - $$mydir | gzip -9 > $${mydir}.tar.gz)

clean:
	rm -f *~ \#*\# *.o mt stinit
