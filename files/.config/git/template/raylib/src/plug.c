#include <raylib.h>

typedef float f32;

extern void
plug_init(void)
{
}

extern void
plug_fini(void)
{
}

extern void
plug_reload_pre(void)
{
}

extern void
plug_reload_post(void)
{
}

extern void
plug_update(f32 dt)
{
	BeginDrawing();

	ClearBackground(RAYWHITE);

	DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);

	EndDrawing();
}
