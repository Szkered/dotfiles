import Xmobar

config :: Config
config =
  defaultConfig
    { -- appearance
      font = "Ubuntu Bold 9",
      additionalFonts =
        [ "Mononoki 11",
          "Font Awesome 6 Free Solid 12",
          "Font Awesome 6 Brands 12"
        ],
      dpi = 163,
      -- Color scheme: Ayu Dark
      bgColor = "#0d1017",
      fgColor = "#bfbdb6",
      -- Position TopSize and BottomSize take 3 arguments:
      --   an alignment parameter (L/R/C) for Left, Right or Center.
      --   an integer for the percentage width, so 100 would be 100%.
      --   an integer for the minimum pixel height for xmobar, so 24 would force a height of at least 24 pixels.
      --   NOTE: The height should be the same as the trayer (system tray) height.
      position = TopSize L 100 30,
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
              [ "--template",
                "<fn=2>\xeaa0</fn> <tx>kB/s <fn=2>\xea9d</fn> <rx>kB/s",
                "--Low",
                "1000", -- units: B/s
                "--High",
                "5000", -- units: B/s
                "--low",
                "#91b362",
                "--normal",
                "#f9af4f",
                "--high",
                "#ea6c73"
              ]
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
              [ "--template",
                "cpu: <total0>%",
                "--Low",
                "50", -- units: %
                "--High",
                "85", -- units: %
                "--low",
                "#91b362",
                "--normal",
                "#f9af4f",
                "--high",
                "#ea6c73"
              ]
              20,
          -- cpu core temperature monitor
          Run $
            CoreTemp
              [ "--template",
                "core: <core0>°C",
                "--Low",
                "70", -- units: °C
                "--High",
                "80", -- units: °C
                "--low",
                "#91b362",
                "--normal",
                "#f9af4f",
                "--high",
                "#ea6c73"
              ]
              50,
          -- memory usage monitor
          Run $
            Memory
              [ "--template",
                "mem: <usedratio>%",
                "--Low",
                "20", -- units: %
                "--High",
                "90", -- units: %
                "--low",
                "#91b362",
                "--normal",
                "#f9af4f",
                "--high",
                "#ea6c73"
              ]
              20,
          -- Disk space free
          Run $
            DiskU
              [ ("/", "<fn=2>\xf0c7</fn>  hdd: <free> free")
              ]
              []
              60,
          -- Battery
          Run $
            Battery
              [ "--template",
                "<acstatus> <left>",
                "--Low",
                "10", -- units: %
                "--High",
                "80", -- units: %
                "--low",
                "#ea6c73",
                "--normal",
                "#f9af4f",
                "--high",
                "#91b362",
                "--", -- battery specific options
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
                "<fc=#91b362><fn=2>\xf1e6</fn></fc>",
                -- charged status
                "-i",
                "<fc=#bfbdb6><fn=2>\xf240</fn></fc>",
                -- percentages
                "--highs",
                "<fn=2>\xf241</fn> ",
                "--mediums",
                "<fn=2>\xf242</fn> ",
                "--lows",
                "<fn=2>\xf243</fn> "
              ]
              50,
          -- Time and date
          Run $ Date "%a %m/%d %H:%M " "date" 10,
          -- apple icon
          Run $ Com "echo" ["<fn=2>\xf179</fn>"] "appleicon" 3600,
          -- Emacs server
          Run $ Com "bash" ["/home/zekun/dotfiles/check_emacs_server.sh"] "emacs" 10,
          -- Prints out the left side items such as workspaces, layout, etc.
          Run UnsafeStdinReader
        ],
      -- layout
      sepChar = "%",
      alignSep = "}{",
      template =
        " %UnsafeStdinReader% }  \
        \<box color=#0d1017 mb=2>%emacs%</box>   \
        \<box color=#0d1017 mb=2><action=`min https://calendar.google.com/calendar/u/1/r`>%date%</action></box> { \
        \<box color=#0d1017 mb=2>%wifi%</box>    \
        \<box color=#0d1017 mb=2>%dynnetwork%</box>    \
        \<box color=#0d1017 mb=2><fc=#bfbdb6><action=`alacritty -e nvtop`>%gpuusage%</action></fc></box>   \
        \<box color=#0d1017 mb=2><fc=#bfbdb6><action=`alacritty -e glances`>%multicpu%</action></fc></box>   \
        \<box color=#0d1017 mb=2>%coretemp%</box>   \
        \<box color=#0d1017 mb=2><fc=#bfbdb6><action=`alacritty -e htop`>%memory%</action></fc></box>   \
        \<box color=#0d1017 mb=2><action=`pavucontrol`>%volume%</action></box>   \
        \<box color=#0d1017 mb=2>%bluetooth%</box>   \
        \<box color=#0d1017 mb=2>%battery%</box>     "
    }

main :: IO ()
main = xmobar config
