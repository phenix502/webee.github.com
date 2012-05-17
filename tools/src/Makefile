CC= gcc
CFLAGS= -Wall -O2
LDFLAGS= 
APPS= proxyd.bin

SOURCE=  proxyd.c

ifneq ($(findstring $(MAKEFLAGS),s),s)
ifndef V
	QUIET		= @
	QUIET_CC	= @echo '   ' CC $@;
	QUIET_DEP	= @echo '   ' DEP $@;
endif
endif

all: .depend $(APPS)

.c.o: .depend
	$(QUIET_CC)$(CC) -o $@ -c $(CFLAGS) $<

proxyd.bin: proxyd.o
	$(QUIET_CC)$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $^

.depend: $(SOURCE)
	$(QUIET_DEP)$(CC) -MM $(CFLAGS) $^ 1>.depend

clean:
	rm -rf *.o $(APPS)

ifneq ($(wildcard .depend),)
include .depend
endif
