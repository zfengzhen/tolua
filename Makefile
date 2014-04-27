CFLAGES = -O2 -DLUA_USE_LINUX -Wall -I./include
LDFLAGES = -L./lib -ltolua++ -lm -Wl,-E -ldl -lreadline -lhistory -lncurses
CC = gcc
OBJSDIR = src
LIB = lib
BIN = bin

OBJS = $(OBJSDIR)/lzio.o \
       $(OBJSDIR)/ltm.o \
       $(OBJSDIR)/lstring.o \
       $(OBJSDIR)/lopcodes.o \
       $(OBJSDIR)/lobject.o \
       $(OBJSDIR)/lmem.o \
       $(OBJSDIR)/lmathlib.o \
       $(OBJSDIR)/llex.o \
       $(OBJSDIR)/linit.o \
       $(OBJSDIR)/lgc.o \
       $(OBJSDIR)/ldump.o \
       $(OBJSDIR)/lfunc.o \
       $(OBJSDIR)/lvm.o \
       $(OBJSDIR)/ltable.o \
       $(OBJSDIR)/lparser.o \
       $(OBJSDIR)/lcode.o \
       $(OBJSDIR)/lstate.o \
       $(OBJSDIR)/loslib.o \
       $(OBJSDIR)/liolib.o \
       $(OBJSDIR)/ldo.o \
       $(OBJSDIR)/ldblib.o \
       $(OBJSDIR)/lauxlib.o \
       $(OBJSDIR)/lbaselib.o \
       $(OBJSDIR)/ltablib.o \
       $(OBJSDIR)/lundump.o \
       $(OBJSDIR)/ldebug.o \
       $(OBJSDIR)/lapi.o \
       $(OBJSDIR)/lstrlib.o \
       $(OBJSDIR)/loadlib.o \
       $(OBJSDIR)/tolua_to.o \
       $(OBJSDIR)/tolua_map.o \
       $(OBJSDIR)/tolua_is.o \
       $(OBJSDIR)/tolua_event.o \
       $(OBJSDIR)/tolua_push.o

LUA_O = $(OBJSDIR)/lua/lua.c
LUAC_O = $(OBJSDIR)/lua/luac.c \
         $(OBJSDIR)/lua/print.c

TOLUA_O = $(OBJSDIR)/tolua/tolua.c \
          $(OBJSDIR)/tolua/toluabind.c

TARGET = libtolua++.a

all:$(TARGET)

libtolua++.so:$(OBJS)
	$(CC) -shared -o $(LIB)/$@ $^ -lm $(CFLAGES)

libtolua++.a:$(OBJS)
	ar rcus $(LIB)/libtolua++.a $^

$(OBJS):%.o:%.c
	$(CC) $? $(CFLAGES) -c -o $@

lua:
	$(CC) $(CFLAGES) -o $(BIN)/$@ $(LUA_O) $(LDFLAGES)
	$(CC) $(CFLAGES) -o $(BIN)/luac $(LUAC_O) $(LDFLAGES)

tolua++:
	$(CC) -o $(BIN)/$@ $(TOLUA_O) $(CFLAGES) $(LDFLAGES)

install:
	mkdir -p /usr/local/bin /usr/local/include
	cd bin && install -p -m 0755 lua luac tolua++ /usr/local/bin
	cd include && install -p -m 0644 lua.h luaconf.h lualib.h lauxlib.h lua.hpp tolua++.h /usr/local/include

uninstall:
	cd /usr/local/bin && $(RM) lua luac tolua++
	cd /usr/local/include && $(RM) lua.h luaconf.h lualib.h lauxlib.h lua.hpp tolua++.h

clean:
	$(RM) $(LIB)/$(TARGET) $(OBJS) $(BIN)/*
