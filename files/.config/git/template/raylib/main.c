#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdint.h>
#include <time.h>

#include <raylib.h>
#include <raygui.h>

#include <dlfcn.h>
#include <sys/stat.h>
#include <sys/stat.h>

extern void plug_init(void);
extern void plug_fini(void);

extern void plug_update(float);
extern void plug_reload_pre(void);
extern void plug_reload_post(void);

#define import_fn(fn) typeof (fn) *fn
#define load_fn(plug, fn) plug.fn = __extension__(typeof (fn) *)dlsym(plug.lib, #fn)

struct plug {
	void *lib;

	import_fn(plug_init);
	import_fn(plug_fini);

	import_fn(plug_update);
	import_fn(plug_reload_pre);
	import_fn(plug_reload_post);
} plug;

#define LIBFILE "src/plug.so"

static bool
file_mtime_get(const char *restrict filename, struct timespec *restrict mtime)
{
	struct stat st = {};

	if (0 == stat(filename, &st)) {
		*mtime = st.st_mtim;
		return true;
	}

	return false;
}

static inline int
timespec_cmp(const struct timespec *restrict lhs, const struct timespec *restrict rhs)
{
	int64_t sec  = (int64_t)lhs->tv_sec  - (int64_t)rhs->tv_sec;
	int32_t nsec = (int32_t)lhs->tv_nsec - (int32_t)rhs->tv_nsec;

	sec = sec ? sec : nsec;

	return (0 < sec) - (0 > sec);
}

extern int
main(void)
{
	// Initialization
	//--------------------------------------------------------------------------------------
	const int screen_width  = 800;
	const int screen_height = 460;

	InitWindow(screen_width, screen_height, "raylib [core] example - basic window");

	SetTargetFPS(60);               // Set our game to run at 60 frames-per-second

	plug.lib = dlopen(LIBFILE, RTLD_NOW);
	load_fn(plug, plug_init);
	load_fn(plug, plug_fini);
	load_fn(plug, plug_update);
	load_fn(plug, plug_reload_pre);
	load_fn(plug, plug_reload_post);
	struct timespec lib_mtime_cur = {};
	struct timespec lib_mtime_new = {};
	struct timespec lib_mtime_old = {};

	file_mtime_get(LIBFILE, &lib_mtime_old);
	lib_mtime_cur = lib_mtime_new = lib_mtime_old;

	plug.plug_init();

	bool reload = false;

	// Main game loop - Detect window close button or ESC key
	while (!WindowShouldClose()) {

		if (file_mtime_get(LIBFILE, &lib_mtime_cur)) {
			if (0 > timespec_cmp(&lib_mtime_old, &lib_mtime_cur)) {
				if (0 == timespec_cmp(&lib_mtime_new, &lib_mtime_cur)) {
					reload = true;
					lib_mtime_old = lib_mtime_cur;
				}
				lib_mtime_new = lib_mtime_cur;
			}
		}

		if (reload) {
			reload = false;
			plug.plug_reload_pre();
			dlclose(plug.lib);
			plug.lib = dlopen(LIBFILE, RTLD_NOW);
			load_fn(plug, plug_init);
			load_fn(plug, plug_fini);
			load_fn(plug, plug_update);
			load_fn(plug, plug_reload_pre);
			load_fn(plug, plug_reload_post);

			plug.plug_reload_post();
		}

		// Draw
		//----------------------------------------------------------------------------------
		plug.plug_update(GetFrameTime());
		//----------------------------------------------------------------------------------
	}

	plug.plug_fini();
	dlclose(plug.lib);

	// De-Initialization
	//--------------------------------------------------------------------------------------
	CloseWindow();        // Close window and OpenGL context
	//--------------------------------------------------------------------------------------

	return 0;
}
