import XMonad
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Ungrab

main :: IO ()
main =
  xmonad $
    def
      { terminal = "alacritty",
        modMask = mod4Mask
      }
      `additionalKeysP` [ ("M-e", spawn "emacs"),
                          ("M-b", spawn "google-chrome-stable"),
                          ("M-C-s", unGrab *> spawn "maim -s ~/Pictures/Screenshots/$(date +%s).png")
                        ]
