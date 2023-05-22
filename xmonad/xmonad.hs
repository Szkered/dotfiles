import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Ungrab

-- Color scheme: Ayu Dark
commonBg = "#0d1017"

commonFg = "#bfbdb6"

red = "#d95757"

red2 = "#f07178"

red3 = "#f26d78"

orange = "#ff8f40"

orange2 = "#f29668"

yellow = "#ffb454"

yellow2 = "#e6b673"

green = "#7fd962"

green2 = "#aad94c"

blue = "#73b8ff"

blue3 = "#59c2ff"

cyan = "#39bae6"

teal = "#95e6cb"

purple = "#d2a6ff"

grey = "#475266"

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

myConfig =
  def
    { manageHook =
        (isFullscreen --> doFullFloat)
          <+> manageDocks
          <+> manageHook def,
      layoutHook = smartBorders (avoidStruts $ layoutHook def),
      terminal = "alacritty",
      borderWidth = 3,
      focusedBorderColor = "#bfbdb6",
      normalBorderColor = "#0d1017",
      modMask = mod4Mask
    }
    `additionalKeysP` myAdditionalKeys

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP =
  xmobarPP
    { ppCurrent = xmobarColor purple "" . wrap "[" "]" . shorten 68,
      ppTitle = xmobarColor commonFg "" . shorten 68
    }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
