; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     pdf-tools
     rust
     lua
     shell-scripts
     vagrant
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            c-c++-enable-clang-support t)
     ess
     (go :variables
         go-use-gometalinter t
         gofmt-command "goimports"
         go-tab-width 4)
     yaml
     react
     ipython-notebook
     osx
     csv
     (python :variables
             python-test-runner 'pytest
             python-enable-yapf-format-on-save t
             python-sort-imports-on-save nil)
     ruby
     html
     markdown
     (haskell :variables
              haskell-enable-hindent-style "johan-tibell")
     javascript
     themes-megapack
     gtags
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; helm
     ivy
     auto-completion
     better-defaults
     emacs-lisp
     git
     markdown
     org
     (shell :variables
            shell-default-shell 'multi-term
            shell-default-height 30
            shell-default-position 'bottom)
     (spell-checking :variables spell-checking-enable-by-default nil)
     syntax-checking
     version-control
     latex
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     doom-themes
     all-the-icons-dired
     all-the-icons
     centered-window
     magit-gh-pulls
     nodejs-repl
     calfw
     calfw-org
     calfw-ical
     calfw-gcal
     itail
     solidity-mode
     shm
     darkroom
     rainbow-mode
     visual-regexp
     org-download
     base16-theme
     ag
     )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'hybrid
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'emacs-lisp-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         doom-vibrant
                         sanityinc-tomorrow-eighties
                         base16-ocean
                         base16-eighties
                         majapahit-light
                         doom-one
                         subatomic
                         spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '(
                               "Monospace"
                               ;; "Source Code Pro"
                               ;; "Fira Code"
                               ;; "Meslo LG S DZ for Powerline"
                               :size 10
                               :weight normal
                               :width normal
                               :powerline-scale 1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ t
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state t
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  ;; (when (string-equal system-type "windows-nt")
  ;;   (setq-default dotspacemacs-default-font '("Consolas"
  ;;                                            :size 14
  ;;                                            :weight normal
  ;;                                            :width normal
  ;;                                            :powerline-scale 1)))

  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "https://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.org/packages/")))
  (push '("melpa-stable" . "stable.melpa.org/packages/") configuration-layer--elpa-archives)
  ;; (push '(helm . "melpa-stable") package-pinned-packages)
  ;; (push '(counsel . "melpa-stable") package-pinned-packages)

  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

  (add-hook 'javascript-mode-hook 'auto-complete-mode)
  (add-hook 'solidity-mode-hook 'auto-complete-mode)

  ;; python mode hooks
  (add-hook 'python-mode-hook 'pyenv-mode)
  (add-hook 'python-mode-hook 'anaconda-mode)

  (if (string-equal system-type "darwin")
      (setenv "WORKON_HOME" "/Users/Zekun/anaconda3/envs")
      (setenv "WORKON_HOME" "/home/zekun/anaconda3/envs")
    )

  ;; fix term mode pasting
  (defun my-term-paste (&optional string)
    (interactive)
    (process-send-string
     (get-buffer-process (current-buffer))
     (if string string (current-kill 0))))

  ;; CUDA extras
  (setenv "LD_LIBRARY_PATH" "/usr/local/cuda-9.0/lib64:/usr/local/cuda/extras/CUPTI/lib64")
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; doom
  (require 'doom-themes)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)

  ;; (setq powerline-height 20)
  (setq powerline-height 28)

  ;; neotree
  (require 'all-the-icons)
  (setq neo-theme 'icons)

  ;; eyebrowse
  (spacemacs/set-leader-keys "o" 'spacemacs/workspaces-transient-state/body)

  ;; Util
  (defun to-underscore ()
    (interactive)
    (progn (replace-regexp "\\([A-Z][a-z]\\)" "_\\1" nil (region-beginning) (region-end))
           (downcase-region (region-beginning) (region-end))))

  ;; term mode switch
  (require 'term)

  (defun term-toggle-mode ()
    "Toggles term between line mode and char mode"
    (interactive)
    (if (term-in-line-mode)
        (term-char-mode)
      (term-line-mode)))

  ;; (define-key term-mode-map (kbd "C-c C-j") 'term-toggle-mode)
  ;; (define-key term-mode-map (kbd "C-c C-k") 'term-toggle-mode)
  ;; (define-key term-raw-map (kbd "C-c C-j") 'term-toggle-mode)
  ;; (define-key term-raw-map (kbd "C-c C-k") 'term-toggle-mode)

  (add-hook 'term-mode-hook (lambda ()
                              (define-key term-mode-map (kbd "C-c C-j") 'term-toggle-mode)
                              (define-key term-mode-map (kbd "C-c C-k") 'term-toggle-mode)
                              (define-key term-raw-map (kbd "C-c C-j") 'term-toggle-mode)
                              (define-key term-raw-map (kbd "C-c C-k") 'term-toggle-mode)
                              ))

  ;; disable flycheck by default
  (setq flycheck-global-modes t)

  ;; pull request
  (require 'magit-gh-pulls)
  (add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)

  ;; nodejs-repl
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "ne" 'nodejs-repl-send-last-expression)
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "nj" 'nodejs-repl-send-line)
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "nr" 'nodejs-repl-send-region)
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "nl" 'nodejs-repl-load-file)
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "n'" 'nodejs-repl-switch-to-repl)
  (spacemacs/set-leader-keys-for-major-mode 'js2-mode "ns" 'nodejs-repl-switch-to-repl)

  ;; Make evil-mode up/down operate in screen lines instead of logical lines
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  ;; Also in visual mode
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line)


  ;; wm
  ;; (define-key evil-motion-state-map "s-j" 'evil-window-decrease-height)
  ;; (define-key evil-motion-state-map "s-k" 'evil-window-increase-height)
  ;; (define-key evil-motion-state-map "s-h" 'evil-window-increase-width)
  ;; (define-key evil-motion-state-map "s-l" 'evil-window-increase-width)


  ;; distraction-free editing mode
  (use-package centered-window :ensure t)
  (setq cwm-frame-internal-border 250)
  (setq cwm-use-vertical-padding t)
  (use-package darkroom)
  (setq darkroom-margins 0.01)
  (add-hook 'darkroom-mode-hook (lambda ()
                                  (setq-local global-hl-line-mode nil)
                                  (centered-window-mode-toggle)
                                  ))

  (use-package rainbow-mode)
  (setq rainbow-html-colors t)

  ;; fringe color should be the same as bg
  (set-face-attribute 'fringe nil
                      ;; :foreground nil
                      :background (face-background 'default))

  ;; vertical border color setting
  ;; (set-face-attribute 'vertical-border nil
  ;;                     :foreground "#282a2e")

  ;; fix mode line file name display(require 'nadvice)
  ;; (defun my-truncate-buffer-name (buf-name)
  ;;   (let ((len (length buf-name)))
  ;;     (cond ((> len 20)
  ;;            (concat (substring buf-name 0 10)
  ;;                    "..."
  ;;                    (substring buf-name (- len 7) len)))
  ;;           (t buf-name))))
  ;; (advice-add 'powerline-buffer-id :filter-return 'my-truncate-buffer-name)

  ;; no line highlight in term mode
  (add-hook 'term-mode-hook (lambda ()
                              (setq-local global-hl-line-mode
                                          nil)))

  ;; indentation setting
  (setq indent-guide-recursive t)
  (setq indent-guide-delay nil)
  (setq-default
   ;; js2-mode
   js2-basic-offset 2
   js-indent-level 2
   ;; web-mode
   css-indent-offset 2
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-attr-indent-offset 2)

  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))

  ;; file extension
  (add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
  (add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.gin\\'" . python-mode))

  ;; powerline separator anti-aliasing
  (if (string-equal system-type "darwin")
      (setq powerline-default-separator 'utf-8)
      (setq powerline-default-separator 'slant)
    )
  (spaceline-compile)

  ;; latex setting
  (setq TeX-parse-self t)
  (setq TeX-auto-save t)
  (setq TeX-PDF-mode t)
  (setq TeX-save-query nil)
  (setq TeX-engine 'xetex)

  ;; TODO what is this?
  (setq visual-fill-column-center-text t)
  (setq visual-fill-column-width 100)

  ;; yasnippet mode kbd
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "\t") nil)
  (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)

  ;; turn off remote host section in spaceline as they takes too much space
  (spaceline-toggle-remote-host-off)

  ;; ag search setting
  (define-key global-map (kbd "C-c s") 'counsel-ag)
  (defun counsel-ag-advice (args)
    "Make counsel-ag aware of project root directory."
    (list nil (projectile-project-root)))
  (advice-add 'counsel-ag :filter-args #'counsel-ag-advice)

  (global-evil-mc-mode 1)

  ;; visual regexp search
  (define-key global-map (kbd "M-%") 'vr/query-replace)
  (setq vr/engine 'pcre2el)

  ;; ggtags kbd
  (define-key global-map (kbd "M-[") 'ggtags-find-definition)

  ;; (keyfreq-mode 1)
  ;; (keyfreq-autosave-mode 1)

  ;; Hasekll config
  (add-to-list 'tramp-remote-path "~/.local/bin") ;; intero over tramp

  (let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
    (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
    (add-to-list 'exec-path my-cabal-path))
  (custom-set-variables '(haskell-tags-on-save t))
  (setq haskell-hoogle-command nil)
  (evil-define-key 'normal haskell-mode-map "K" 'haskell-hoogle-lookup-from-local)
  (add-hook 'haskell-mode-hook 'structured-haskell-mode)
  (add-hook 'haskell-mode-hook 'intero-mode)
  ;; (setq intero-global-mode 1)
  ;; (setq intero-whitelist '("~/prog/quorum-tools" "~/prog/constellation"))
  ;; (setq intero-blacklist '("~/prog/Learning-Haskell"))
  (add-hook 'haskell-mode-hook (lambda ()
                                 (define-key haskell-mode-map (kbd "M-[") 'intero-goto-definition)
                                 (define-key haskell-mode-map (kbd "C-M-;") 'comment-dwim)
                                 (add-hook 'completion-at-point-functions 'intero-repl-completion-at-point)
                                 ))
  ;; (add-hook 'haskell-mode-hook (if intero-mode
  ;;                                  (progn
  ;;                                    (add-hook 'completion-at-point-functions 'intero-repl-completion-at-point)
  ;;                                    )))
  (spacemacs/set-leader-keys-for-major-mode 'haskell-mode "S" 'structured-haskell-mode)

  ;; window resizing key bindings
  (global-set-key (kbd "<s-up>") 'shrink-window)
  (global-set-key (kbd "<s-down>") 'enlarge-window)
  (global-set-key (kbd "<s-left>") 'shrink-window-horizontally)
  (global-set-key (kbd "<s-right>") 'enlarge-window-horizontally)

  ;; evil-snipe impletmented with avy
  (defun avy-goto-char-2-in-line (char1 char2 &optional arg)
    "Jump to the currently visible CHAR1 followed by CHAR2.
     This is a scoped version of `avy-goto-char-2', where the scope is
     the current line. "
    (interactive (list (read-char "char 1: " t)
                       (read-char "char 2: " t)
                       current-prefix-arg))
    (avy-with avy-goto-char-2-in-line
      (avy-goto-char-2
       char1 char2 arg
       (line-beginning-position) (line-end-position))))
  (evil-define-key 'normal global-map (kbd "C-f") 'avy-goto-char-2-in-line)

  ;; org-mode config
  (add-hook 'text-mode-hook (lambda ()
                              (setq left-fringe-width 0)
                              (setq right-fringe-width 0)
                              ))
  (add-hook 'org-mode-hook (lambda ()
                             (visual-line-mode)
                             (org-indent-mode)))
  (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
  (setq org-mobile-inbox-for-pull "~/Dropbox/org/flagged.org")
  (setq org-directory "~/Dropbox/org")
  (setq org-agenda-files (list "~/Dropbox/org/inbox.org"
                               "~/Dropbox/org/work.org"
                               "~/Dropbox/org/journal.org"
                               "~/Dropbox/org/personal.org"))


  (defun filter-org-file (file)
    (equal (car (last (split-string file "\\."))) "org")
    )

  (setq all-org-files
        (mapcar (lambda (x) (concat "~/Dropbox/org/" x))
                (seq-filter 'filter-org-file (directory-files "~/Dropbox/org/"))))

  (setq org-refile-targets
        '((nil :maxlevel . 3)
          (org-agenda-files :maxlevel . 3)
          (all-org-files :maxlevel . 3)))


  (setq org-default-notes-file (concat org-directory "/inbox.org"))
  (setq org-todo-keywords
        '((sequence "TODO(t)" "HANGER(h)" "RUNWAY(r)" "AIRBORNE(a)" "|" "DONE(d)" "FAIL(f)" "CANCELLED(c)")
        ))
  (setq org-capture-templates
        '(("t" "Task" entry (file+headline "~/Dropbox/org/inbox.org" "Staging Area")
           "* TODO %?")
          ("b" "Buy" entry (file+headline "~/Dropbox/org/personal.org" "Shopping List")
           "* TODO %?")
          ("d" "Debug" entry (file+headline "~/Dropbox/org/inbox.org" "Staging Area")
           "* TODO %?\n %i\n  %a")
          ("v" "Vocab" plain (file "~/Dropbox/org/vocab_builder.org")
           "%?")
          ("j" "Journal" entry (file+olp+datetree "~/Dropbox/org/journal.org")
           "*** \n%?\nEntered on %U\n")))
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (require 'org-drill)
  (add-to-list 'org-modules 'org-drill)
  (setq org-habit-show-all-today t)
  (evil-define-key 'normal org-mode-map "K" 'osx-dictionary-search-word-at-point)

  (defun air-org-skip-subtree-if-habit ()
    "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (if (string= (org-entry-get nil "STYLE") "habit")
          subtree-end
        nil)))

  (defun air-org-skip-subtree-if-priority (priority)
    "Skip an agenda subtree if it has a priority of PRIORITY.
     PRIORITY may be one of the characters ?A, ?B, or ?C."
    (let ((subtree-end (save-excursion (org-end-of-subtree t)))
          (pri-value (* 1000 (- org-lowest-priority priority)))
          (pri-current (org-get-priority (thing-at-point 'line t))))
      (if (= pri-value pri-current)
          subtree-end
        nil)))

  (defun chanining/archive-when-done ()
    "Archive current entry if it is marked as DONE"
    (when (org-entry-is-done-p)
      (org-toggle-archive-tag)))

  ;; (add-hook 'org-after-todo-state-change-hook
  ;;           'chanining/archive-when-done)

  (setq org-default-priority ?C)

  (setq org-agenda-clockreport-parameter-plist
        (quote (:link t :maxlevel 3 :fileskip0 t :narrow 80 :formula %)))

  ;; (setq org-agenda-clockreport-parameter-plist
  ;;       (quote (:link t :tags "Meeting|Learn" :maxlevel 3 :fileskip0 t :narrow 80 :formula %)))

  (setq org-clock-idle-time 5)
  (setq org-columns-default-format "%50ITEM(Task) %2PRIORITY %10Effort(Effort){:} %10CLOCKSUM")

  (setq org-agenda-log-mode-items '(closed state clock))

  (setq org-agenda-custom-commands
        '(
          ("d" "Daily agenda and all TODOs"
           (
            (tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "Important & Urgent:")))
            (tags "PRIORITY=\"B\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "Important & Not Urgent:")))
            (tags "TODO=\"AIRBORNE\""
                  ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                  (air-org-skip-subtree-if-priority ?A)
                                                  (air-org-skip-subtree-if-priority ?B)))
                   (org-agenda-overriding-header "AIRBORNE Projects:")))
            (agenda "" ((org-agenda-ndays 1)))
            (tags "TODO=\"RUNWAY\""
                  ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                  (air-org-skip-subtree-if-priority ?A)))
                   (org-agenda-overriding-header "Projects on the RUNWAY:")))
            (alltodo ""
                     ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                     (air-org-skip-subtree-if-priority ?A)
                                                     (org-agenda-skip-if nil '(scheduled deadline))
                                                     (org-agenda-skip-entry-if 'todo '("AIRBORNE" "RUNWAY"))))
                      (org-agenda-overriding-header "Projects / Tasks in the HANGER:")))
            )
           ((org-agenda-compact-blocks nil)
            (org-agenda-archives-mode t)
            (org-agenda-start-on-weekday 1)
            ))
          ("w" "Weekly review"
           agenda ""
           ((org-agenda-span 'week)
            (org-agenda-start-on-weekday 1)
            (org-agenda-start-with-log-mode t)
            (org-agenda-archives-mode t)
            )
           )
          )
        )

  ;; (setq org-agenda-todo-ignore-timestamp 'past)
  ;; (setq org-agenda-tags-todo-honor-ignore-options t)
  ;; (setq org-agenda-todo-ignore-scheduled 'all)

  (setq org-agenda-block-separator (string-to-char " "))

  (add-to-list 'load-path "~/.emacs.d/private/local")
  ;; (require 'org-clock-budget)

  (setq org-format-latex-options (plist-put org-format-latex-options :scale 3.0))

  ;; dired
  (setq dired-listing-switches "-alh")
  (setq dired-du-size-format t)

  ;; react
  (add-hook 'react-mode-hook 'rainbow-mode)

  ;;;;;;;;;;;;;;;;;;;;;;;
  ;; python settings
  ;;;;;;;;;;;;;;;;;;;;;;;

  ;; autopep8
;;   (defcustom python-autopep8-path (executable-find "autopep8")
;;     "autopep8 executable path."
;;     :group 'python
;;     :type 'string)

;;   (defun python-autopep8 ()
;;     "Automatically formats Python code to conform to the PEP 8 style guide.
;; $ autopep8 --in-place --aggressive --aggressive <filename>"
;;     (interactive)
;;     (when (eq major-mode 'python-mode)
;;       (shell-command
;;        (format "%s --in-place --aggressive --ignore=E501 %s" python-autopep8-path
;;                (shell-quote-argument (buffer-file-name))))
;;       (revert-buffer t t t)))

;;   (bind-key "C-c C-a" 'python-autopep8)

;;   (eval-after-load 'python
;;     '(if python-autopep8-path
;;          (add-hook 'after-save-hook 'python-autopep8)))

  ;; autoflake
  (defcustom python-autoflake-path (executable-find "autoflake")
    "autoflake executable path."
    :group 'python
    :type 'string)

  (defun python-autoflake ()
    "Automatically clean up python codes
$ autoflake --in-place --remove-unused-variables --remove-all-unused-imports --remove-duplicate-keys --expand-star-imports <filename>"
    (interactive)
    (when (eq major-mode 'python-mode)
      (shell-command
       (format
        "%s --in-place --remove-unused-variables --remove-all-unused-imports --remove-duplicate-keys --expand-star-imports %s"
        python-autoflake-path
        (shell-quote-argument (buffer-file-name))))
      (revert-buffer t t t)))


  (bind-key "C-c C-a" 'python-autoflake)

  ;; (eval-after-load 'python
  ;;   '(if python-autoflake-path
  ;;        (add-hook 'after-save-hook 'python-autoflake)))

  (defun restart-python-repl ()
    "Restart python console"
    (interactive)
    (kill-process "Python")
    (sleep-for 0.05)
    (kill-buffer "*Python*")
    (python-start-or-switch-repl))

  (spacemacs/set-leader-keys-for-major-mode 'python-mode "\"" 'restart-python-repl)

  (defun my-python-send-buffer ()
    "Restart python console before evaluate buffer"
    (interactive)
    (kill-process "Python")
    (sleep-for 0.05)
    (kill-buffer "*Python*")
    (python-start-or-switch-repl)
    (spacemacs/alternate-window)
    (python-shell-send-buffer))

  (spacemacs/set-leader-keys-for-major-mode 'python-mode "b" 'my-python-send-buffer)

  ;; calfw
  (require 'calfw)
  (require 'calfw-org)
  (require 'calfw-ical)
  (require 'calfw-gcal)
  (setq cfw:org-agenda-schedule-args '(:timestamp :deadline :scheduled :sexp))

  (defun my-open-calendar ()
    (interactive)
    (cfw:open-calendar-buffer
     :contents-sources
     (list
      (cfw:org-create-source "Green")  ; orgmode source
      (cfw:ical-create-source
       "gcal"
       "https://calendar.google.com/calendar/ical/derek.zekun.shi%40gmail.com/private-bc815aa252aac82a83b51fe2c0587716/basic.ics"
       "IndianRed") ; google calendar ICS
      )))

  ;; (custom-set-faces
  ;;  '(cfw:face-title ((t (:foreground "#f0dfaf" :weight bold :height 2.0 :inherit variable-pitch))))
  ;;  '(cfw:face-header ((t (:foreground "#d0bf8f" :weight bold))))
  ;;  '(cfw:face-sunday ((t :foreground "#cc9393" :background "grey10" :weight bold)))
  ;;  '(cfw:face-saturday ((t :foreground "#8cd0d3" :background "grey10" :weight bold)))
  ;;  '(cfw:face-holiday ((t :background "grey10" :foreground "#8c5353" :weight bold)))
  ;;  '(cfw:face-grid ((t :foreground "DarkGrey")))
  ;;  '(cfw:face-default-content ((t :foreground "#bfebbf")))
  ;;  '(cfw:face-periods ((t :foreground "cyan")))
  ;;  '(cfw:face-day-title ((t :background "grey10")))
  ;;  '(cfw:face-default-day ((t :weight bold :inherit cfw:face-day-title)))
  ;;  '(cfw:face-annotation ((t :foreground "RosyBrown" :inherit cfw:face-day-title)))
  ;;  '(cfw:face-disable ((t :foreground "DarkGray" :inherit cfw:face-day-title)))
  ;;  '(cfw:face-today-title ((t :background "#7f9f7f" :weight bold)))
  ;;  '(cfw:face-today ((t :background: "grey10" :weight bold)))
  ;;  '(cfw:face-select ((t :background "#2f2f2f")))
  ;;  '(cfw:face-toolbar ((t :foreground "Steelblue4" :background "Steelblue4")))
  ;;  '(cfw:face-toolbar-button-off ((t :foreground "Gray10" :weight bold)))
  ;;  '(cfw:face-toolbar-button-on ((t :foreground "Gray50" :weight bold))))

  ;; go mode
  (require 'go-autocomplete)
  (require 'auto-complete-config)
  (ac-config-default)

  ;; company mode fix
  (with-eval-after-load 'company
    (define-key company-active-map (kbd "C-f") nil))
  ;; ;; <return> is for windowed Emacs; RET is for terminal Emacs
  ;; (dolist (key '("<return>" "RET"))
  ;;   ;; Here we are using an advanced feature of define-key that lets
  ;;   ;; us pass an "extended menu item" instead of an interactive
  ;;   ;; function. Doing this allows RET to regain its usual
  ;;   ;; functionality when the user has not explicitly interacted with
  ;;   ;; Company.
  ;;   (define-key company-active-map (kbd key)
  ;;     `(menu-item nil company-complete
  ;;                 :filter ,(lambda (cmd)
  ;;                            (when (company-explicit-action-p)
  ;;                              cmd)))))
  ;; (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  ;; (define-key company-active-map (kbd "SPC") nil)

  ;; ;; Company appears to override the above keymap based on company-auto-complete-chars.
  ;; ;; Turning it off ensures we have full control.
  ;; (setq company-auto-complete-chars nil)


  ;; Ligature for Fira Code. Maybe I'll want it someday?
  ;; (when (window-system)
  ;;   (set-default-font "Fira Code"))
  ;; (let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
  ;;                (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
  ;;                (36 . ".\\(?:>\\)")
  ;;                (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
  ;;                (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
  ;;                (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
  ;;                (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
  ;;                (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
  ;;                (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
  ;;                (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
  ;;                (48 . ".\\(?:x[a-zA-Z]\\)")
  ;;                (58 . ".\\(?:::\\|[:=]\\)")
  ;;                (59 . ".\\(?:;;\\|;\\)")
  ;;                (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
  ;;                (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
  ;;                (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
  ;;                (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
  ;;                (91 . ".\\(?:]\\)")
  ;;                (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
  ;;                (94 . ".\\(?:=\\)")
  ;;                (119 . ".\\(?:ww\\)")
  ;;                (123 . ".\\(?:-\\)")
  ;;                (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
  ;;                (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
  ;;                )
  ;;              ))
  ;;   (dolist (char-regexp alist)
  ;;     (set-char-table-range composition-function-table (car char-regexp)
  ;;                           `([,(cdr char-regexp) 0 font-shape-gstring]))))

  )

;; do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector ["black" "light gray" "dark gray" "light slate gray"])
 '(background-color "#202020")
 '(background-mode dark)
 '(beacon-color "#F8BBD0")
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(cursor-color "#cccccc")
 '(custom-safe-themes
   '("f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "a56a6bf2ecb2ce4fa79ba636d0a5cf81ad9320a988ec4e55441a16d66b0c10e0" "868f73b5cf78e72ca2402e1d48675e49cc9a9619c5544af7bf216515d22b58e7" "f2057733672d3b119791f5b7d1a778bf8880121f22ea122a21d221b45081f49e" default))
 '(diary-entry-marker 'font-lock-variable-name-face)
 '(emms-mode-line-icon-image-cache
   '(image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };"))
 '(evil-emacs-state-cursor '("#D50000" hbar) t)
 '(evil-insert-state-cursor '("#D50000" bar) t)
 '(evil-normal-state-cursor '("#F57F17" box) t)
 '(evil-visual-state-cursor '("#66BB6A" box) t)
 '(evil-want-Y-yank-to-eol t)
 '(fci-rule-character-color "#192028")
 '(fci-rule-color "#3C3D37")
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(foreground-color "#cccccc")
 '(frame-background-mode 'dark)
 '(gnus-logo-colors '("#259ea2" "#adadad") t)
 '(gnus-mode-line-image-cache
   '(image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };") t)
 '(haskell-tags-on-save t)
 '(highlight-changes-colors '("#d33682" "#6c71c4"))
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    '("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2")))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   '(("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100)))
 '(hl-bg-colors
   '("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00"))
 '(hl-fg-colors
   '("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36"))
 '(hl-sexp-background-color "#1c1f26")
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
 '(linum-format " %3i ")
 '(magit-diff-use-overlays nil)
 '(notmuch-search-line-faces
   '(("unread" :foreground "#aeee00")
     ("flagged" :foreground "#0a9dff")
     ("deleted" :foreground "#ff2c4b" :bold t)))
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(org-agenda-files
   '("~/Dropbox/org/inbox.org" "~/Dropbox/org/work.org" "~/Dropbox/org/journal.org" "~/Dropbox/org/personal.org"))
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   '(org-projectile airline-themes dired-du peep-dired frames-only-mode all-the-icons memoize white-sand-theme rebecca-theme org-mime helm helm-core exotica-theme ghub smartparens evil goto-chg undo-tree highlight counsel bind-map bind-key async f s dash avy popup gh marshal logito pcache ht calfw-ical calfw-gcal magit-gh-pulls nodejs-repl calfw-org calfw counsel-tramp centered-window emoji-cheat-sheet-plus company-emoji logview toml-mode racer flycheck-rust cargo rust-mode tronesque-theme pastels-on-dark-theme ess-R-object-popup lua-mode insert-shebang fish-mode company-shell flycheck-gometalinter vagrant disaster company-c-headers cmake-mode clang-format ess-smart-equals ess-R-data-view ctable ess julia-mode go-guru go-eldoc company-go go-mode yaml-mode ein request-deferred websocket deferred shm evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu eval-sexp-fu elisp-slime-nav dumb-jump diminish column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile packed aggressive-indent ace-window ace-link centered-window-mode google-this wgrep-ag eziam-theme highlight-indent-guides base16-theme focus writeroom-mode darkroom visual-regexp-steroids visual-regexp doom-themes pandoc pdf-tools tablist reveal-in-osx-finder pbcopy osx-trash osx-dictionary launchctl keyfreq olivetti csv-mode org-beautify-theme helm-tramp helm-pydoc helm-gtags helm-css-scss flyspell-correct-helm ace-jump-helm-line ledger-mode flycheck-ledger counsel-gtags ggtags ag visual-fill-column evil-goggles company-auctex auctex-latexmk auctex all-the-icons-ivy all-the-icons-gnus all-the-icons-dired solaire-mode spaceline-all-the-icons atom-one-dark-theme rainbow-mode itail vagrant-tramp company-anaconda pyenv-mode-auto yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode cython-mode anaconda-mode pythonic git-gutter-fringe flycheck-pos-tip git-gutter-fringe+ fringe-helper git-gutter+ git-gutter flyspell-correct-ivy flyspell-correct pos-tip flycheck-haskell diff-hl auto-dictionary rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby less-css-mode unfill mwim company-web web-mode tagedit slim-mode scss-mode sass-mode pug-mode haml-mode emmet-mode web-completion-data load-theme-buffer-local color-theme-buffer-local org-category-capture org-present org-pomodoro alert log4e gntp org-download htmlize gnuplot xterm-color shell-pop multi-term eshell-z eshell-prompt-extras esh-help wgrep smex ivy-hydra counsel-projectile swiper ivy mmm-mode markdown-toc markdown-mode gh-md zenburn-theme zen-and-art-theme underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme sunny-day-theme sublime-themes subatomic256-theme subatomic-theme spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme seti-theme reverse-theme railscasts-theme purple-haze-theme professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme organic-green-theme omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme naquadah-theme mustang-theme monokai-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme madhat2r-theme lush-theme light-soap-theme jbeans-theme jazz-theme ir-black-theme inkpot-theme heroku-theme hemisu-theme hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gandalf-theme flatui-theme flatland-theme farmhouse-theme espresso-theme dracula-theme django-theme darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme evil-unimpaired intero flycheck hlint-refactor hindent helm-hoogle haskell-snippets company-ghci company-ghc ghc haskell-mode company-cabal cmm-mode solidity-mode smeargle orgit magit-gitflow helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit magit-popup git-commit with-editor web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc company-tern dash-functional tern coffee-mode spinner helm-company helm-c-yasnippet fuzzy company-statistics company auto-yasnippet yasnippet adaptive-wrap ac-ispell auto-complete ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state -colors
                    '("#DCDCCC" . "#383838")))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(powerline-default-separator 'box)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(tabbar-background-color "#ffffff")
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil)
 '(when
      (or
       (not
        (boundp 'ansi-term-color-vector))
       (not
        (facep
         (aref ansi-term-color-vector 0)))))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(cfw:face-annotation ((t :foreground "RosyBrown" :inherit cfw:face-day-title)))
 '(cfw:face-day-title ((t :background "grey10")))
 '(cfw:face-default-content ((t :foreground "#bfebbf")))
 '(cfw:face-default-day ((t :weight bold :inherit cfw:face-day-title)))
 '(cfw:face-disable ((t :foreground "DarkGray" :inherit cfw:face-day-title)))
 '(cfw:face-grid ((t :foreground "DarkGrey")))
 '(cfw:face-header ((t (:foreground "#d0bf8f" :weight bold))))
 '(cfw:face-holiday ((t :background "grey10" :foreground "#8c5353" :weight bold)))
 '(cfw:face-periods ((t :foreground "cyan")))
 '(cfw:face-saturday ((t :foreground "#8cd0d3" :background "grey10" :weight bold)))
 '(cfw:face-select ((t :background "#2f2f2f")))
 '(cfw:face-sunday ((t :foreground "#cc9393" :background "grey10" :weight bold)))
 '(cfw:face-title ((t (:foreground "#f0dfaf" :weight bold :height 2.0 :inherit variable-pitch))))
 '(cfw:face-today ((t :background: "grey10" :weight bold)))
 '(cfw:face-today-title ((t :background "#7f9f7f" :weight bold)))
 '(cfw:face-toolbar ((t :foreground "Steelblue4" :background "Steelblue4")))
 '(cfw:face-toolbar-button-off ((t :foreground "Gray10" :weight bold)))
 '(cfw:face-toolbar-button-on ((t :foreground "Gray50" :weight bold)))
 '(fringe ((t (:background unspecified)))))
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector ["black" "light gray" "dark gray" "light slate gray"])
 '(background-color "#202020")
 '(background-mode dark)
 '(beacon-color "#F8BBD0")
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(cursor-color "#cccccc")
 '(custom-safe-themes
   (quote
    ("a56a6bf2ecb2ce4fa79ba636d0a5cf81ad9320a988ec4e55441a16d66b0c10e0" "868f73b5cf78e72ca2402e1d48675e49cc9a9619c5544af7bf216515d22b58e7" "f2057733672d3b119791f5b7d1a778bf8880121f22ea122a21d221b45081f49e" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(evil-emacs-state-cursor (quote ("#D50000" hbar)) t)
 '(evil-insert-state-cursor (quote ("#D50000" bar)) t)
 '(evil-normal-state-cursor (quote ("#F57F17" box)) t)
 '(evil-visual-state-cursor (quote ("#66BB6A" box)) t)
 '(evil-want-Y-yank-to-eol t)
 '(fci-rule-character-color "#192028")
 '(fci-rule-color "#3C3D37" t)
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(foreground-color "#cccccc")
 '(gnus-logo-colors (quote ("#259ea2" "#adadad")) t)
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")) t)
 '(haskell-tags-on-save t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-sexp-background-color "#1c1f26")
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(js-indent-level 2)
 '(js2-basic-offset 2 t)
 '(js2-bounce-indent-p t)
 '(linum-format " %3i ")
 '(magit-diff-use-overlays nil)
 '(notmuch-search-line-faces
   (quote
    (("unread" :foreground "#aeee00")
     ("flagged" :foreground "#0a9dff")
     ("deleted" :foreground "#ff2c4b" :bold t))))
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(org-agenda-files
   (quote
    ("~/Dropbox/org/inbox.org" "~/Dropbox/org/work.org" "~/Dropbox/org/journal.org" "~/Dropbox/org/personal.org")))
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   (quote
    (white-sand-theme symon string-inflection ruby-refactor rebecca-theme realgud test-simple loc-changes load-relative password-generator org-brain ivy-purpose window-purpose imenu-list impatient-mode godoctor go-rename flycheck-bashate exotica-theme evil-org evil-lion editorconfig all-the-icons memoize dante lcr company-lua cmake-ide levenshtein browse-at-remote calfw-org calfw counsel-tramp centered-window emoji-cheat-sheet-plus company-emoji logview toml-mode racer flycheck-rust cargo rust-mode tronesque-theme pastels-on-dark-theme ess-R-object-popup lua-mode insert-shebang fish-mode company-shell flycheck-gometalinter vagrant disaster company-c-headers cmake-mode clang-format ess-smart-equals ess-R-data-view ctable ess julia-mode go-guru go-eldoc company-go go-mode yaml-mode ein request-deferred websocket deferred shm org-projectile evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu eval-sexp-fu elisp-slime-nav dumb-jump diminish column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile packed aggressive-indent ace-window ace-link centered-window-mode google-this wgrep-ag eziam-theme highlight-indent-guides base16-theme focus writeroom-mode darkroom visual-regexp-steroids visual-regexp doom-themes pandoc pdf-tools tablist reveal-in-osx-finder pbcopy osx-trash osx-dictionary launchctl keyfreq olivetti csv-mode org-beautify-theme helm-tramp helm-pydoc helm-gtags helm-css-scss flyspell-correct-helm ace-jump-helm-line ledger-mode flycheck-ledger counsel-gtags ggtags ag visual-fill-column evil-goggles company-auctex auctex-latexmk auctex all-the-icons-ivy all-the-icons-gnus all-the-icons-dired solaire-mode spaceline-all-the-icons atom-one-dark-theme rainbow-mode itail vagrant-tramp company-anaconda pyenv-mode-auto yapfify pyvenv pytest pyenv-mode py-isort pip-requirements live-py-mode hy-mode cython-mode anaconda-mode pythonic git-gutter-fringe flycheck-pos-tip git-gutter-fringe+ fringe-helper git-gutter+ git-gutter flyspell-correct-ivy flyspell-correct pos-tip flycheck-haskell diff-hl auto-dictionary rvm ruby-tools ruby-test-mode rubocop rspec-mode robe rbenv rake minitest chruby bundler inf-ruby less-css-mode unfill mwim company-web web-mode tagedit slim-mode scss-mode sass-mode pug-mode haml-mode emmet-mode web-completion-data load-theme-buffer-local color-theme-buffer-local org-category-capture org-present org-pomodoro alert log4e gntp org-download htmlize gnuplot xterm-color shell-pop multi-term eshell-z eshell-prompt-extras esh-help wgrep smex ivy-hydra counsel-projectile swiper ivy mmm-mode markdown-toc markdown-mode gh-md zenburn-theme zen-and-art-theme underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme sunny-day-theme sublime-themes subatomic256-theme subatomic-theme spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme seti-theme reverse-theme railscasts-theme purple-haze-theme professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme organic-green-theme omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme naquadah-theme mustang-theme monokai-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme madhat2r-theme lush-theme light-soap-theme jbeans-theme jazz-theme ir-black-theme inkpot-theme heroku-theme hemisu-theme hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gandalf-theme flatui-theme flatland-theme farmhouse-theme espresso-theme dracula-theme django-theme darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme evil-unimpaired intero flycheck hlint-refactor hindent helm-hoogle haskell-snippets company-ghci company-ghc ghc haskell-mode company-cabal cmm-mode solidity-mode smeargle orgit magit-gitflow helm-gitignore gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link evil-magit magit magit-popup git-commit with-editor web-beautify livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc company-tern dash-functional tern coffee-mode spinner helm-company helm-c-yasnippet fuzzy company-statistics company auto-yasnippet yasnippet adaptive-wrap ac-ispell auto-complete ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state -colors
                      (quote
                       ("#DCDCCC" . "#383838")))))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(powerline-default-separator (quote box))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(tabbar-background-color "#ffffff")
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(when
      (or
       (not
        (boundp
         (quote ansi-term-color-vector)))
       (not
        (facep
         (aref ansi-term-color-vector 0)))))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
