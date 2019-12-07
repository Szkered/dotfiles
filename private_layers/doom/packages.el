;;; packages.el --- doom layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: zekun <zekun@zekun-AERO-15XV8>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq doom-packages
      '(
        (doom-themes :requires all-the-icons)
        solaire-mode
        ))

(defun doom/post-init-doom-themes ()
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)
  ;; (doom-themes-neotree-config)
  )

(defun doom/init-solaire-mode ()
  ;; Enable solaire-mode anywhere it can be enabled
  (solaire-global-mode +1)
  ;; To enable solaire-mode unconditionally for certain modes:
  (add-hook 'ediff-prepare-buffer-hook #'solaire-mode)

  ;; ...if you use auto-revert-mode, this prevents solaire-mode from turning
  ;; itself off every time Emacs reverts the file
  (add-hook 'after-revert-hook #'turn-on-solaire-mode)

  ;; highlight the minibuffer when it is activated:
  (add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)

  ;; if the bright and dark background colors are the wrong way around, use this
  ;; to switch the backgrounds of the `default` and `solaire-default-face` faces.
  ;; This should be used *after* you load the active theme!
  ;;
  ;; NOTE: This is necessary for themes in the doom-themes package!
  (solaire-mode-swap-bg)
  )
