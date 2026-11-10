main.o: CPPFLAGS += -I./subprojects/raylib/src
main.o: CPPFLAGS += -I./subprojects/raygui/src

src/%.o: CPPFLAGS += -I./subprojects/raylib/src
src/%.o: CPPFLAGS += -I./subprojects/raygui/src

src/plug.so: src/plug.o

main: LDFLAGS += -lm
main: LDFLAGS += -lX11
main: LDFLAGS += -rdynamic

main: $(RL_OBJ)
main: main.o

BIN += main
BIN += src/plug.so

OBJ += main.o
OBJ += $(wildcard src/*.o)

SRC += main.c
SRC += $(wildcard src/*.c)
SRC += $(wildcard src/*.h)
