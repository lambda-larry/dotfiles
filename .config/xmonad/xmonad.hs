import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.NoBorders
import XMonad.Config.Desktop
import XMonad.Config.Kde
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Layout.IM
import XMonad.Layout.Spacing
import XMonad.Layout.Reflect
import XMonad.Layout.NoBorders
import XMonad.Util.Loggers
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Data.Ratio ((%))
import Data.List


import Foreign.C.Types (CLong)

-- https://mail.haskell.org/pipermail/xmonad/2014-December/014412.html
checkAtom :: String -> String -> Query Bool
checkAtom name value = ask >>= \w -> liftX $ do
  a   <- getAtom name
  val <- getAtom value
  mbr <- getProp w a
  case mbr of
    Just r -> return $ elem val $ map fromIntegral r
    _      -> return False

-- | Helper to read a property
getProp :: Window -> Atom -> X (Maybe [CLong])
getProp w a = withDisplay $ \dpy -> io $ getWindowProperty32 dpy a w


gaps = spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True


main :: IO ()
main =  xmonad $
  dynamicEasySBs dzenSpawner $ ewmhFullscreen $ docks $ ewmh $
  kde4Config
  { borderWidth        = 1
  , modMask            = mod4Mask
  , normalBorderColor  = "#282A36"
  , focusedBorderColor = "#BD93F9"
  , manageHook         = manageHook kde4Config <+> windowsRules
  , keys               = keymaps <> keys desktopConfig
  , layoutHook         = lessBorders Screen $ gaps $ desktopLayoutModifiers layouts
  }
  where
    layouts = tiled ||| noBorders Full ||| im_layout tiled ||| reflectHoriz (withIM (225 % 1000) (Role "im-chat") Full)
      where
        -- default tiling algorithm partitions the screen into two panes
        tiled   = Tall nmaster delta ratio

        -- The default number of windows in the master pane
        nmaster = 1

        -- Default proportion of screen occupied by master pane
        ratio   = 1/2

        -- Percent of screen to increment by when resizing panes
        delta   = 3/100

        im_chat = withIM (225 % 1000) (Role "im-chat")

        im_layout = reflectHoriz . im_chat . reflectHoriz


keymaps XConfig{modMask = modm} = M.fromList
    [ ((modm .|. shiftMask, xK_q), spawn quitKde)
    , ((modm,  xK_p),              spawn "dmenu_run -i -nb '#282A36' -nf '#BD93F9' -sb '#BD93F9' -sf '#282A36'")
    , ((modm,  xK_BackSpace),  kill)

    , ((modm,  xK_m),  withFocused toggleBorder)

    , ((modm,  xK_grave),  toggleWS)

    , ((modm,  xK_comma),  prevScreen)
    , ((modm,  xK_period), nextScreen)
    , ((modm .|. shiftMask,    xK_comma),  shiftPrevScreen >> prevScreen)
    , ((modm .|. shiftMask,    xK_period), shiftNextScreen >> nextScreen)
    , ((modm .|. controlMask,  xK_comma),  swapPrevScreen  >> prevScreen)
    , ((modm .|. controlMask,  xK_period), swapNextScreen  >> nextScreen)

    , ((modm,  xK_bracketleft),  moveTo Prev nonEmptyHiddenWS)
    , ((modm,  xK_bracketright), moveTo Next nonEmptyHiddenWS)

    , ((modm .|. shiftMask,  xK_bracketleft),  shiftTo Prev nonEmptyHiddenWS)
    , ((modm .|. shiftMask,  xK_bracketright), shiftTo Next nonEmptyHiddenWS)

    , ((modm .|. controlMask,  xK_bracketleft),  moveTo Prev emptyHiddenWS)
    , ((modm .|. controlMask,  xK_bracketright), moveTo Next emptyHiddenWS)
    , ((modm .|. controlMask .|. shiftMask,  xK_bracketleft),  shiftTo Prev emptyHiddenWS)
    , ((modm .|. controlMask .|. shiftMask,  xK_bracketright), shiftTo Next emptyHiddenWS)
    ]
    where
      nonEmptyHiddenWS = not emptyWS :&: hiddenWS
      emptyHiddenWS    = emptyWS :&: hiddenWS

      not = XMonad.Actions.CycleWS.Not

      quitKde = unwords
        [ "dbus-send"
        , "--print-reply"
        , "--dest=org.kde.ksmserver"
        , "/KSMServer"
        , "org.kde.KSMServerInterface.logout"
        , "int32:1"
        , "int32:0"
        , "int32:1"
        ]


dzencmd = "dzen2" ++ dzenFlags
dzenFlags = " -e onstart=unstick -dock -bg '#282A36' -ta l -fn monospace -h 20 "


windowsRules = composeAll
  -- Remove border from and float torbrowser to have a normal viewport...
  [ className =? "Tor Browser"              --> hasBorder False <+> doCenterFloat
  , className =? "kruler"                   --> doFloat
  , className =? "ksmserver-logout-greeter" --> kdeHook
  , role      =? "About"                    --> doFloat
  , role      =? "Dialog"                   --> doFloat
  , role      =? "PictureInPicture"         --> doFloat
  , className =? "plasma"                   --> kdeHook
  , className =? "Plasma"                   --> kdeHook
  , className =? "plasma-desktop"           --> kdeHook
  , className =? "Plasma-desktop"           --> kdeHook
  , checkNotification                       --> kdeHook
  , appletPopUp                             --> kdeHook
  , isKDETrayWindow                         --> kdeHook
  , transience'
  ]
  where
    checkNotification :: Query Bool
    checkNotification = checkAtom "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_NOTIFICATION"

    appletPopUp :: Query Bool
    appletPopUp = checkAtom "_NET_WM_WINDOW_TYPE" "_KDE_NET_WM_WINDOW_TYPE_APPLET_POPUP"

    role = stringProperty "WM_WINDOW_ROLE"

    kdeHook = doIgnore


myPP = dzenPP
  { ppCurrent         = dzenColor "#282A36" "#BD93F9" . pad
  , ppVisible         = dzenColor "#FF79C6" "#282A36" . pad
  , ppHidden          = dzenColor "#BD93F9" "#282A36" . pad
  , ppHiddenNoWindows = const ""
  , ppUrgent          = dzenColor "#FF5555" "#282A36" . pad
  , ppWsSep           = ""
  , ppSep             = ""
  , ppLayout          = dzenColor "#50FA7B" "#282A36" . pad
  , ppTitle           = const ""
  }



dzenSpawner :: ScreenId -> IO StatusBarConfig
dzenSpawner id = statusBarPipe (dzencmd ++ screenFlag) $ pure myPP { ppExtras = map (logOnActiveScreen . extraColor) [logTitleOnScreen id] }
  where
    extraColor = dzenColorL "#BD93F9" "#282A36"
    screenFlag = (++) "-xs " $ show $ fromEnum $ succ id
    logOnActiveScreen = logWhenActive id
