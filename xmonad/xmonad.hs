import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
  ( avoidStruts,
    manageDocks,
  )
import XMonad.Hooks.ManageHelpers
  ( doFullFloat,
    isDialog,
    isFullscreen,
  )
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.Accordion
import XMonad.Layout.Gaps
  ( Direction2D (D, L, R, U),
    GapMessage
      ( DecGap,
        IncGap,
        ToggleGaps
      ),
    GapSpec,
    gaps,
    setGaps,
  )
import XMonad.Layout.GridVariants (Grid (Grid))
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
  ( StdTransformers (NBFULL),
  )
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
  ( Border (Border),
    Spacing (smartBorder),
    setScreenSpacing,
    setScreenSpacingEnabled,
    setSmartSpacing,
    setWindowSpacing,
    setWindowSpacingEnabled,
    spacingRaw,
  )
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns (ThreeCol (ThreeColMid))
import XMonad.Util.EZConfig (additionalKeysP)
import qualified XMonad.Util.ExtensibleState as XS
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.Ungrab (unGrab)

-- Color scheme: Ayu Dark
commonBg, commonFg, white, red, red2, red3, orange, orange2, yellow, yellow2, yellow3, green, green2, blue, blue2, cyan, teal, teal2, purple, purple2, magenta, grey :: String
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
blue2 = "#59c2ff"
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
  [ ("M-e", spawn "emacsclient -r --eval '(emacs-startup-screen)'"),
    ("M-n", spawn "emacsclient -c --eval '(+vterm/here nil)'"),
    ("M-s", spawn "emacsclient -c --eval '(org-roam-capture-research-quick)'"),
    ("M-/", spawn "rofi -show combi"),
    ("M-'", spawn "rofi-pass"),
    ("M-w", spawn "~/dotfiles/rofi-wifi-menu.sh"),
    ("M-r", spawn "~/dotfiles/remap.sh; xset r rate 250 60"),
    ("M-S-e", spawn "~/dotfiles/reload_emacs.sh"),
    -- edit text using emacs
    ("M-x", spawn "emacsclient -r --eval \"(emacs-everywhere)\""),
    -- add arxiv article using the existing emacsclient window
    ( "M-y",
      spawn
        "emacsclient -r --eval '(zotra-add-entry-and-pdf-from-url '\" $(printf '\"%s\"' \"$(xclip -o)\")\"' )'"
    ),
    -- add arxiv article using a new emacsclient window
    ( "M-S-y",
      spawn
        "emacsclient -c --eval '(zotra-add-entry-and-pdf-from-url '\" $(printf '\"%s\"' \"$(xclip -o)\")\"' )'"
    ),
    -- browser
    ("M-c", spawn "qutebrowser"),
    ("M-C-c", spawn "emacsclient -c --eval '(eaf-open-browser \"google.com\")'"),
    -- screenshot
    ("M-C-x", unGrab *> spawn "maim -s ~/Pictures/Screenshots/$(date +%s).png"),
    -- external display
    ("M-o", spawn "~/dotfiles/monitor_screen.sh"),
    -- interal display
    ("M-S-o", spawn "~/dotfiles/laptop_screen.sh"),
    ("M-C-r", spawn "systemctl reboot"),
    ("M-C-s", spawn "systemctl poweroff"),
    ("<F10>", spawn "playerctl play-pause"),
    ("M-0", spawn "amixer set Master toggle"),
    ("M--", spawn "amixer set Master 5%- umute"),
    ("M-=", spawn "amixer set Master 5%+ umute"),
    ("M-m", sendMessage $ Toggle NBFULL),
    ("M-g", sequence_ [cycleGapBorders, spawn "~/dotfiles/toggle_picom_style.sh"]),
    ("M-f", spawn "pcmanfm"),
    ( "M-S-f",
      spawn
        "rofi -dpi 1 -modi file-browser-extended -show file-browser-extended \
        \-file-browser-dir '/home/zekun'               \
        \-file-browser-depth 6                         \
        \-file-browser-hide-hidden-symbol ''           \
        \-file-browser-path-sep '/'                    \
        \-file-browser-up-text 'up'                    \
        \-file-browser-up-icon 'go-previous'           \
        \-file-browser-oc-search-path                  \
        \-file-browser-exclude workspace               \
        \-file-browser-exclude '*.org'"
    ),
    ("M-z", spawn "rofi -show calc -no-show-match -no-sort"),
    ("M-C-l", spawn "betterlockscreen -l")
  ]

myLayout = tiled ||| Mirror tiled
  where
    -- grid = Grid (16 / 10)
    -- threeCol = ThreeColMid nmaster delta ratio
    tiled = Tall nmaster delta ratio
    nmaster = 1 -- Default number of windows in the master pane
    ratio = 1 / 2 -- Default proportion of screen occupied by master pane
    delta = 3 / 100 -- Percent of screen to increment by when resizing panes

myGaps :: [GapSpec]
myGaps =
  [ [(L, 0), (R, 0), (U, 0), (D, 0)],
    [(L, 30), (R, 30), (U, 40), (D, 60)]
  ]

myBorders :: [Border]
myBorders = [Border 0 0 0 0, Border 10 10 10 10]

newtype GapState = GapIndex Int deriving (Show)

instance ExtensionClass GapState where
  initialValue = GapIndex 0

newtype GapBorderState = GapBorderEnabled Bool deriving (Show)

instance ExtensionClass GapBorderState where
  initialValue = GapBorderEnabled False

cycleGapBorders :: X ()
cycleGapBorders = do
  enabled <- XS.gets $ \(GapBorderEnabled enabled) -> not enabled
  idx <- XS.gets $ \(GapBorderEnabled enabled) -> if enabled then 0 else 1
  XS.put $ GapBorderEnabled $ enabled
  setSmartSpacing enabled
  setScreenSpacing $ myBorders !! idx
  setScreenSpacingEnabled enabled
  setWindowSpacing $ myBorders !! idx
  setWindowSpacingEnabled enabled
  sendMessage (setGaps $ myGaps !! idx)

myLayoutGap =
  gaps (head myGaps) $
    spacingRaw False (head myBorders) False (head myBorders) False $
      smartBorders $
        myLayout

myLayoutHook = mkToggle (NBFULL ?? EOT) $ myLayoutGap

myManageHook =
  composeAll
    [ className =? "Gimp" --> doFloat,
      className =? "Pavucontrol" --> doFloat,
      className =? "Blueman-manager" --> doFloat,
      className =? "fcitx5-config-qt" --> doFloat,
      isDialog --> doFloat
    ]

myBorderWidth = 3

myWorkspaces = map show [1 .. 9]

myStartupHook = do
  spawn "exec ~/dotfiles/lock.sh"
  spawnOnce "nitrogen --restore"
  spawnOnce "picom -b"
  spawnOnce "fcitx5"
  spawnOnce "xfce4-power-manager"

myConfig =
  def
    { manageHook = myManageHook <+> manageDocks <+> manageHook def,
      -- layoutHook = myLayout,
      layoutHook = myLayoutHook,
      workspaces = myWorkspaces,
      terminal = "alacritty",
      borderWidth = myBorderWidth,
      focusedBorderColor = yellow2,
      normalBorderColor = commonFg,
      startupHook = myStartupHook,
      modMask = mod4Mask
    }
    `additionalKeysP` myAdditionalKeys

-- Custom PP
myXmobarPP :: PP
myXmobarPP =
  def
    { ppSep = magentaFg " • ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = whiteFg . wrap "  " "  " . xmobarBorder "Top" teal2 2,
      ppHidden = greyFg . wrap "  " "  ",
      -- ppHiddenNoWindows = lowWhiteFg . wrap " " "",
      ppUrgent = redFg . wrap (yellowFg "!") (yellowFg "!"),
      ppOrder = \[ws, l, _, wins] -> [ws, l, wins],
      ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap " " "" . xmobarBorder "Top" teal2 2 . whiteFg . ppWindow
    formatUnfocused = wrap " " "" . lowWhiteFg . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 15

    -- colors
    magentaFg = xmobarColor magenta ""
    whiteFg = xmobarColor white ""
    yellowFg = xmobarColor yellow3 ""
    redFg = xmobarColor red3 ""
    lowWhiteFg = xmobarColor commonFg ""
    greyFg = xmobarColor grey ""

main =
  xmonad
    . ewmh
    . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig
