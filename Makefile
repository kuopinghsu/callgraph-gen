CC       = gcc
SYS     := $(shell gcc -dumpmachine)

XMLFILE  = contrib/default.xml

ifneq (, $(findstring linux, $(SYS)))
CFLAGS   = -I/usr/include/libxml2 -Wformat-truncation=0 -Wno-stringop-truncation
LDFLAGS  =
else ifneq (, $(findstring mingw, $(SYS)))
CFLAGS   = -I/mingw64/include/libxml2 -Wformat-truncation=0 -Wno-stringop-truncation
LDFLAGS  = -L/mingw64/lib
else ifneq (, $(findstring cygwin, $(SYS)))
CFLAGS   = -I/usr/include/libxml2 -Wformat-truncation=0 -Wno-stringop-truncation
LDFLAGS  =
else ifneq (, $(findstring darwin, $(SYS)))
CFLAGS   = -I/usr/local/opt/libxml2/include/libxml2
LDFLAGS  = -L/usr/local/opt/libxml2/lib
endif

CFLAGS  += -g -O3 -Wall
CFLAGS  += -I./uthash/include
LDFLAGS += -lpcre2-8 -lxml2
OBJECTS  = graphgen.o xmlparser.o
EXEFILE  = graphgen

all: $(EXEFILE)

.SUFFIXES: .c .h .o
%.o: %.c %.h Makefile default_xml.h
	$(CC) $(CFLAGS) -o $@ -c $<

$(EXEFILE): $(OBJECTS)
	$(CC) -o $(EXEFILE) $(OBJECTS) $(LDFLAGS)

default_xml.h: $(XMLFILE)
	@cat $(XMLFILE) | xxd -i > default_xml.h

clean:
	-rm $(EXEFILE) $(OBJECTS) default_xml.h

