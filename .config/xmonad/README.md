# Xmonad config

Combine an expressive windows manager from `xmonad` with a complete desktop
experience from `KDE`, to get the best of both worlds.

The configuration is not perfectly integrated with KDE and is still WIP.


## Known issues

* On hot-plug new monitors, `plasmashell` on the new monitor gets higher
  order in the window stack and draw the wallpaper over windows in the
  workspace. A workaround to fix the issue is to drag a floating window and
  hover the window over the new screen, to force a reorder and redraw.

* Notification does not get floated.

* The application launcher does not always get drawn on the very top, which
  makes it impossible to use.
