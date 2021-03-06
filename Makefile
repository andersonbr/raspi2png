OBJS=raspi2jpeg.o
BIN=raspi2jpeg

CFLAGS+=-Wall -g -O3 $(shell pkg-config --cflags libjpeg)
LDFLAGS+=-L/opt/vc/lib/ -lbcm_host $(shell pkg-config --libs libjpeg) -lm

INCLUDES+=-I/opt/vc/include/ -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux

all: $(BIN)

install: $(BIN)
	install -d -m 755 $(DESTDIR)/usr/bin/
	install -m 755 $(BIN) $(DESTDIR)/usr/bin/raspi2jpeg

%.o: %.c
	@rm -f $@ 
	$(CC) $(CFLAGS) $(INCLUDES) -g -c $< -o $@ -Wno-deprecated-declarations

$(BIN): $(OBJS)
	$(CC) -o $@ -Wl,--whole-archive $(OBJS) $(LDFLAGS) -Wl,--no-whole-archive -rdynamic

clean:
	@rm -f $(OBJS)
	@rm -f $(BIN)
