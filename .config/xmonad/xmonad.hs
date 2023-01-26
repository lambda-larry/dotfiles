import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.NoBorders
import XMonad.Config.Desktop
import XMonad.Config.Kde
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Layout.IM
import XMonad.Layout.Spacing
import XMonad.Layout.Reflect
import XMonad.Layout.NoBorders
import XMonad.Util.Loggers
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Data.Ratio ((%))


gaps = spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True


main :: IO ()
main =  xmonad $
  dynamicEasySBs dzenSpawner $ ewmhFullscreen $ docks $ ewmh $
  kde4Config
  { borderWidth        = 1
  , modMask            = mod4Mask
  -- , workspaces         = map show [0..9]
  , workspaces         = ["!", "@", "#", "$", "%", "^^", "&", "*", "("]
  , normalBorderColor  = "#282A36"
  , focusedBorderColor = "#BD93F9"
  , manageHook         = manageHook kde4Config <+> windowsRules
  , keys               = keymaps <> keys desktopConfig
  , layoutHook         = lessBorders Screen $ gaps $ desktopLayoutModifiers layouts
  }
  where
    layouts = tiled ||| (reflectHoriz . twitch_chat $ reflectHoriz tiled) ||| noBorders Full
      where
        -- default tiling algorithm partitions the screen into two panes
        tiled   = Tall nmaster delta ratio

        -- The default number of windows in the master pane
        nmaster = 1

        -- Default proportion of screen occupied by master pane
        ratio   = 1/2

        -- Percent of screen to increment by when resizing panes
        delta   = 3/100

        -- TODO: make my own withIM from scratch, that is more flexible
        twitch_chat = withIM (1%5) (Title "lambda_larry - Chat - Twitch — Mozilla Firefox Private Browsing")


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
    , ((modm .|. controlMask,  xK_comma),  swapPrevScreen)
    , ((modm .|. controlMask,  xK_period), swapNextScreen)

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

      -- TODO: Manage the window and make it float
      quitKde = "dbus-send --print-reply --dest=org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout int32:1 int32:0 int32:1"


dzencmd = "dzen2" ++ dzenFlags
dzenFlags = " -e onstart=unstick -dock -bg '#282A36' -ta l -fn monospace -h 20 "


windowsRules = composeAll
  -- Remove border from torbrowser to have a normal viewport...
  [ className =? "Tor Browser"              --> hasBorder False
  -- torbrowser has to float to have the same viewport as other torbrowser users.
  , className =? "Tor Browser"              --> doFloat
  , className =? "kruler"                   --> doFloat
  , className =? "ksmserver-logout-greeter" --> doFloat
  , role      =? "About"                    --> doFloat
  , role      =? "Dialog"                   --> doFloat
  , className =? "plasma"                   --> doFloat
  , className =? "Plasma"                   --> doFloat
  , className =? "plasma-desktop"           --> doFloat
  , className =? "Plasma-desktop"           --> doFloat
  -- _NET_WM_WINDOW_TYPE_NOTIFICATION
  ]
  where
    role = stringProperty "WM_WINDOW_ROLE"
    -- TODO: Make =~ operator for regex or substring


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
