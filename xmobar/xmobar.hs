import Xmobar

-- helper function to make template less verbose
wrapStrs strs left right = foldr (\s acc -> [left, s, right] ++ acc) [] strs

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

config :: Config
config =
  let colorCoding = ["--low", green, "--normal", orange, "--high", red]
      colorCodingInv = ["--low", red, "--normal", orange, "--high", green]
      sepLeft = "<box color=" ++ commonBg ++ " mb=2>"
      sepRight = "</box>   "
      sepDotColored = "<fc=" ++ magenta ++ ">•</fc>"
      sepDot = "•"
      templateLeft = ["%XMonadLog%", "  " ++ sepDotColored ++ " %emacs%"]
      templateMid = ["<action=`qutebrowser https://calendar.google.com/calendar/u/1/r`>%date%</action>"]
      templateRight =
        [ "%dynnetwork%",
          "<action=`./dotfiles/rofi-wifi-menu.sh`>%wifi%</action>",
          "<action=`alacritty -e nvtop`>%gpuusage%</action>",
          "<action=`alacritty -e glances`>cpu: %coretemp% " ++ sepDot ++ " %memory% " ++ sepDot ++ " %multicpu%</action>",
          "<action=`pavucontrol`>%volume%</action>",
          "<action=`blueman-manager`>%bluetooth%</action>",
          "<action=`fcitx5-configtool`>%inputmethod%</action>",
          "<action=`xfce4-power-manager-settings`>%battery%</action>"
        ]
   in defaultConfig
        { -- layout
          sepChar = "%",
          alignSep = "}{",
          template = concat $ templateLeft ++ ["}"] ++ wrapStrs templateMid sepLeft sepRight ++ ["{"] ++ wrapStrs templateRight sepLeft sepRight,
          -- appearance
          font = "Ubuntu Bold 9",
          additionalFonts =
            [ "Mononoki 11",
              "Font Awesome 6 Free Solid 12",
              "Font Awesome 6 Brands 12"
            ],
          dpi = 163,
          -- Color scheme: Ayu Dark
          bgColor = commonBg,
          fgColor = commonFg,
          -- Position TopSize and BottomSize take 3 arguments:
          --   an alignment parameter (L/R/C) for Left, Right or Center.
          --   an integer for the percentage width, so 100 would be 100%.
          --   an integer for the minimum pixel height for xmobar, so 24 would force a height of at least 24 pixels.
          --   NOTE: The height should be the same as the trayer (system tray) height.
          position = TopSize L 100 40,
          -- general behavior
          lowerOnStart = True, -- send to bottom of window stack on start
          hideOnStart = False, -- start with window unmapped (hidden)
          allDesktops = True, -- show on all desktops
          persistent = True, -- enable/disable hiding (True = disabled)

          -- The root folder where icons are stored.
          iconRoot = ".xmonad/xpm/", -- default: "."

          -- plugins
          --   Numbers can be automatically colored according to their value. xmobar
          --   decides color based on a three-tier/two-cutoff system, controlled by
          --   command options:
          --     --Low sets the low cutoff
          --     --High sets the high cutoff
          --
          --     --low sets the color below --Low cutoff
          --     --normal sets the color between --Low and --High cutoffs
          --     --High sets the color above --High cutoff
          --
          --   The --template option controls how the plugin is displayed. Text
          --   color can be set by enclosing in <fc></fc> tags. For more details
          --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
          commands =
            [ -- network activity monitor (dynamic interface resolution)
              Run $
                DynNetwork
                  ( [ "--template",
                      "<fn=2>\xeaa0</fn> <tx>kB/s <fn=2>\xea9d</fn> <rx>kB/s",
                      "--Low",
                      "1000", -- units: B/s
                      "--High",
                      "5000", -- units: B/s
                      "--width",
                      "6"
                    ]
                      ++ colorCodingInv
                  )
                  10,
              -- Wi-Fi
              Run $ Com "bash" ["/home/zekun/dotfiles/get_wifi_name.sh"] "wifi" 60,
              -- Volume
              Run $ Com "bash" ["/home/zekun/dotfiles/get_volume.sh"] "volume" 1,
              -- Bluetooth
              Run $ Com "bash" ["/home/zekun/dotfiles/get_bluetooth.sh"] "bluetooth" 1,
              -- Gpu usage
              Run $ Com "echo" ["<fn=2>\xf2db</fn>"] "gpuicon" 3600,
              Run $ Com "bash" ["/home/zekun/dotfiles/gpustats.sh"] "gpuusage" 20,
              -- Cpu usage in percent
              Run $
                MultiCpu
                  ( [ "--template",
                      "<total0>%",
                      "--Low",
                      "50", -- units: %
                      "--High",
                      "85", -- units: %
                      "--width",
                      "2"
                    ]
                      ++ colorCoding
                  )
                  20,
              -- cpu core temperature monitor
              Run $
                CoreTemp
                  ( [ "--template",
                      "<core0>°C",
                      "--Low",
                      "70", -- units: °C
                      "--High",
                      "80" -- units: °C
                    ]
                      ++ colorCoding
                  )
                  50,
              -- memory usage monitor
              Run $
                Memory
                  ( [ "--template",
                      "<usedratio>%",
                      "--Low",
                      "20", -- units: %
                      "--High",
                      "90" -- units: %
                    ]
                      ++ colorCoding
                  )
                  20,
              -- Disk space free
              Run $ DiskU [("/", "<fn=2>\xf0c7</fn>  hdd: <free> free")] [] 60,
              -- Battery
              Run $
                Battery
                  ( [ "--template",
                      "<acstatus> <left>",
                      "--Low",
                      "10", -- units: %
                      "--High",
                      "80" -- units: %
                    ]
                      ++ colorCodingInv
                      ++ [ "--", -- battery specific options
                      -- to include a percentage symbol in left
                           "-P",
                           -- low battry threshold
                           "-A",
                           "5",
                           "-a",
                           "notify-send -u critical 'Battery running out!!'",
                           -- discharging status
                           "-o",
                           "(<timeleft>)",
                           -- AC "on" status
                           "-O",
                           "<fc=" ++ green ++ "><fn=2>\xf1e6</fn></fc>",
                           -- charged status
                           "-i",
                           "<fc=" ++ commonFg ++ "><fn=2>\xf240</fn></fc>",
                           -- percentages
                           "--highs",
                           "<fn=2>\xf241</fn> ",
                           "--mediums",
                           "<fn=2>\xf242</fn> ",
                           "--lows",
                           "<fn=2>\xf243</fn> "
                         ]
                  )
                  50,
              -- Time and date
              Run $ Date "%a %m/%d %H:%M " "date" 10,
              -- apple icon
              Run $ Com "echo" ["<fn=2>\xf179</fn>"] "appleicon" 3600,
              -- Emacs server
              Run $ Com "bash" ["/home/zekun/dotfiles/check_emacs_server.sh"] "emacs" 10,
              -- Prints out the left side items such as workspaces, layout, etc.
              Run XMonadLog,
              -- Get current input method
              Run $ Com "bash" ["/home/zekun/dotfiles/get_inputmethod.sh"] "inputmethod" 10
            ]
        }

main :: IO ()
main = xmobar config
