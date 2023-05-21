import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Ungrab

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
  xmobarPP {ppCurrent = xmobarColor "green" "" . wrap "<" ">" . shorten 68}

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
