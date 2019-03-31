;;; packages.el --- distraction-free layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: zekun <zekun@zekun-AERO-15XV8>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq distraction-free-packages
      '(darkroom
        centered-window)
)

(defun distraction-free/init-centered-window ()
  (use-package centered-window
    :ensure t
    :config
    (setq cwm-frame-internal-border 250)
    (setq cwm-use-vertical-padding t)
    ))

(defun distraction-free/init-darkroom ()
  (use-package darkroom
    :init
    (add-hook 'darkroom-mode-hook (lambda ()
                                    (setq-local global-hl-line-mode nil)
                                    (centered-window-mode-toggle)
                                    ))
    :config
    (setq darkroom-margins 0.01)
    ))
