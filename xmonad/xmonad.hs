import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks)
import XMonad.Hooks.ManageHelpers (doFullFloat, isDialog, isFullscreen)
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.ThreeColumns (ThreeCol (ThreeColMid))
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Util.Ungrab (unGrab)

-- Color scheme: Ayu Dark
commonBg = "#0d1017"

commonFg = "#bfbdb6"

white = "#f8f8f2"

red = "#d95757"

red2 = "#f07178"

red3 = "#f26d78"

orange = "#ff8f40"

orange2 = "#f29668"

yellow = "#ffb454"

yellow2 = "#e6b673"

yellow3 = "#f1fa8c"

green = "#7fd962"

green2 = "#aad94c"

blue = "#73b8ff"

blue3 = "#59c2ff"

cyan = "#39bae6"

teal = "#95e6cb"

teal2 = "#8be9fd"

purple = "#d2a6ff"

purple2 = "#bd93f9"

magenta = "#ff79c6"

grey = "#475266"

-- keybinds
myAdditionalKeys :: [(String, X ())]
myAdditionalKeys =
  [ ("M-e", spawn "emacsclient -r --eval \"(emacs-startup-screen)\""), -- run emacsclient
    ("M-/", spawn "rofi -show combi"),
    ("M-'", spawn "rofi-pass"),
    ("M-w", spawn "~/dotfiles/rofi-wifi-menu.sh"),
    ("M-r", spawn "~/dotfiles/remap.sh; xset r rate 250 60"), -- remap keyboard
    ("M-S-e", spawn "~/dotfiles/reload_emacs.sh"),
    ("M-x", spawn "emacsclient -r --eval \"(emacs-everywhere)\""), -- edit text using emacs
    ("M-y", spawn "emacsclient -r --eval '(zotra-add-entry-and-pdf-from-url '\" $(printf '\"%s\"' \"$(xclip -o)\")\"' )'"), -- edit text using emacs
    ("M-c", spawn "prime-run min"), -- browser
    ("M-C-x", unGrab *> spawn "maim -s ~/Pictures/Screenshots/$(date +%s).png"), -- screenshot
    ("M-o", spawn "~/dotfiles/monitor_screen.sh"), -- external display
    ("M-S-o", spawn "~/dotfiles/laptop_screen.sh"), -- interal display
    ("M-C-r", spawn "systemctl reboot"),
    ("M-C-s", spawn "systemctl poweroff"),
    ("<F10>", spawn "playerctl play-pause"),
    ("<F11>", spawn "amixer -c 0 -q set Master 2dB-"),
    ("<F12>", spawn "amixer -c 0 -q set Master 2dB+")
  ]

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled = Tall nmaster delta ratio
    nmaster = 1 -- Default number of windows in the master pane
    ratio = 1 / 2 -- Default proportion of screen occupied by master pane
    delta = 3 / 100 -- Percent of screen to increment by when resizing panes

myManageHook =
  composeAll
    [ className =? "Gimp" --> doFloat,
      className =? "Pavucontrol" --> doFloat,
      isDialog --> doFloat
    ]

myConfig =
  def
    { manageHook = myManageHook <+> manageDocks <+> manageHook def,
      layoutHook = myLayout,
      terminal = "alacritty",
      borderWidth = 3,
      focusedBorderColor = "#bfbdb6",
      normalBorderColor = "#0d1017",
      modMask = mod4Mask
    }
    `additionalKeysP` myAdditionalKeys

-- Custom PP
myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = magentaFg " • ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = whiteFg . wrap " " "" . xmobarBorder "Top" teal2 2,
      ppHidden = greyFg . wrap " " "",
      -- ppHiddenNoWindows = lowWhiteFg . wrap " " "",
      ppUrgent = redFg . wrap (yellowFg "!") (yellowFg "!"),
      ppOrder = \[ws, l, _, wins] -> [ws, l, wins],
      ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (whiteFg "[") (whiteFg "]") . whiteFg . ppWindow
    formatUnfocused = wrap (greyFg "[") (greyFg "]") . greyFg . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 15

    -- colors
    magentaFg = xmobarColor magenta ""
    whiteFg = xmobarColor white ""
    yellowFg = xmobarColor yellow3 ""
    redFg = xmobarColor red3 ""
    lowWhiteFg = xmobarColor commonFg ""
    greyFg = xmobarColor grey ""

-- main = xmonad . ewmh =<< myBar toggleStrutsKey myConfig
main =
  xmonad
    . ewmh
    . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig
