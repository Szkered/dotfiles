import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Ungrab

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
    `additionalKeysP` [ ("M-e", spawn "emacsclient -r --eval \"(emacs-startup-screen)\""), -- run emacsclient
                        ("M-/", spawn "rofi -show combi"), --run rofi combined mode
                        ("M-'", spawn "rofi -show run"),
                        ("M-E", spawn "doom sync & systemctl --user restart emacs"), -- reload emacs server, doesn't work very well
                        ("M-x", spawn "emacsclient -r --eval \"(emacs-everywhere)\""), -- edit text using emacs
                        ("M-c", spawn "google-chrome-stable"), -- chrome
                        ("M-C-x", unGrab *> spawn "maim -s ~/Pictures/Screenshots/$(date +%s).png"), -- screenshot
                        ("M-o", spawn "xrandr --output DP1 --auto --pos 0x0 --rotate normal --primary --output eDP1 --off & remap"), -- external display
                        ("M-O", spawn "xrandr --output DP1 --off --output eDP1 --auto & remap"), -- interal display
                        ("M-C-O", spawn "xrandr --output DP1 --auto & xrandr --output eDP1 --auto & remap"), -- both display
                        ("M-C-r", spawn "systemctl reboot"),
                        ("M-C-s", spawn "systemctl poweroff"),
                        ("<XF86MonBrightnessUp>", spawn "xrandr --output eDP1 --brightness 1"),
                        ("<XF86MonBrightnessDown>", spawn "xrandr --output eDP1 --brightness 0.7"),
                        ( "<XF86KbdBrightnessUp>",
                          spawn
                            "/archive/repos/backlights/xkb_backlight_key up 10"
                        ),
                        ( "<XF86KbdBrightnessDown>",
                          spawn
                            "/archive/repos/backlights/xkb_backlight_key down 10"
                        ),
                        ( "<XF86AudioMute>",
                          spawn "amixer -q set Master togglemute"
                        ),
                        ( "<XF86AudioLowerVolume>",
                          spawn "amixer -c 0 -q set Master 2dB-"
                        ),
                        ( "<XF86AudioRaiseVolume>",
                          spawn "amixer -c 0 -q set Master 2dB+"
                        ),
                        ("<XF86AudioPlay>", spawn "playerctl play-pause"),
                        ("<XF86AudioNext>", spawn "playerctl next"),
                        ("<XF86AudioPrev>", spawn "playerctl prev")
                      ]

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP =
  xmobarPP {ppCurrent = xmobarColor "green" "" . wrap "<" ">" . shorten 68}

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
