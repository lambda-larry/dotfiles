#include <raylib.h>
#include <raygui.h>

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

	static bool showMessageBox = false;
	if (GuiButton((Rectangle){ 24, 24, 120, 30 }, "#191#Show Message")) showMessageBox = true;

	if (showMessageBox)
	{
		int btnActive = -1;
		GuiMessageBox((Rectangle){ 85, 70, 250, 100 },
				"#191#Message Box", "Hi! This is a message!", "Nice;Cool", &btnActive);

		if (btnActive >= 0) showMessageBox = false;
	}

	EndDrawing();
}
