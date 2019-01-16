
# the installed path of pcre2
PCRE    = /usr/local

CFLAGS  = -g -O3 -Wall -Wformat-truncation=0
CFLAGS += -I./uthash/include -I$(PCRE)/include -L$(PCRE)/lib
LDFLAGS = -lpcre2-8
OBJECTS = graphgen.o
EXEFILE = graphgen

all: $(EXEFILE)

.SUFFIXES: .c .h .o
%.o: %.c %.h Makefile
	$(CC) $(CFLAGS) -o $@ -c $<

$(EXEFILE): $(OBJECTS)
	$(CC) $(CFLAGS) -o $(EXEFILE) $(OBJECTS) $(LDFLAGS)

clean:
	-rm $(EXEFILE) $(OBJECTS)
