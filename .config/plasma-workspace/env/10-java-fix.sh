case "$(basename "$KDEWM")" in
  xmonad|dwm) export _JAVA_AWT_WM_NONREPARENTING=1;;
  *) ;;
esac
