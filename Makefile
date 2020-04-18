
SYS := $(shell gcc -dumpmachine)

ifneq (, $(findstring linux, $(SYS)))
CFLAGS   = -I/usr/include/libxml2 -Wformat-truncation=0 -Wno-stringop-truncation
LDFLAGS  =
else ifneq (, $(findstring mingw, $(SYS)))
CFLAGS   = -I/mingw64/include/libxml2 -L/mingw64/lib
LDFLAGS  =
else ifneq (, $(findstring cygwin, $(SYS)))
CFLAGS   =
LDFLAGS  =
else ifneq (, $(findstring darwin, $(SYS)))
CFLAGS   = -I/usr/local/opt/libxml2/include/libxml2
LDFLAGS  = -L/usr/local/opt/libxml2/lib
endif

CFLAGS  += -g -O3 -Wall #-D__PREDEFINED_ARRAY__
CFLAGS  += -I./uthash/include
LDFLAGS += -lpcre2-8 -lxml2
OBJECTS  = graphgen.o xmlparser.o default_xml.o
EXEFILE  = graphgen

all: $(EXEFILE)

.SUFFIXES: .c .h .o
%.o: %.c %.h Makefile default_xml.c
	$(CC) $(CFLAGS) -o $@ -c $<

$(EXEFILE): $(OBJECTS)
	$(CC) -o $(EXEFILE) $(OBJECTS) $(LDFLAGS)

default_xml.c: contrib/default.xml
	@cp contrib/default.xml default_xml
	@xxd -i default_xml > $@
	@$(RM) default_xml

clean:
	-rm $(EXEFILE) $(OBJECTS) default_xml.c

