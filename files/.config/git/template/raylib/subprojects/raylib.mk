./subprojects/raylib/src/%.o: CPPFLAGS += -D_GLFW_X11
./subprojects/raylib/src/%.o: CPPFLAGS += -D_DEFAULT_SOURCE
./subprojects/raylib/src/%.o: CPPFLAGS += -DPLATFORM_DESKTOP_GLFW
./subprojects/raylib/src/%.o: CPPFLAGS += -DGRAPHICS_API_OPENGL_33
./subprojects/raylib/src/%.o: CPPFLAGS += -I./subprojects/raylib/src
./subprojects/raylib/src/%.o: CPPFLAGS += -I./subprojects/raylib/src/external/glfw/include

RL_OBJ += ./subprojects/raylib/src/rcore.o
RL_OBJ += ./subprojects/raylib/src/rglfw.o
RL_OBJ += ./subprojects/raylib/src/rtext.o
RL_OBJ += ./subprojects/raylib/src/rtextures.o
RL_OBJ += ./subprojects/raylib/src/rshapes.o
RL_OBJ += ./subprojects/raylib/src/rmodels.o
RL_OBJ += ./subprojects/raylib/src/raudio.o
