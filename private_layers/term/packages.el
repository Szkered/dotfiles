;;; packages.el --- term layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: zekun <zekun@zekun-AERO-15XV8>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq term-packages
  '(term)
)

(defun term/post-init-term ()
  (defun term-toggle-mode ()
    "Toggles term between line mode and char mode"
    (interactive)
    (if (term-in-line-mode)
        (term-char-mode)
      (term-line-mode)))

  (add-hook 'term-mode-hook (lambda ()
                              (define-key term-mode-map (kbd "C-c C-j") 'term-toggle-mode)
                              (define-key term-mode-map (kbd "C-c C-k") 'term-toggle-mode)
                              (define-key term-raw-map (kbd "C-c C-j") 'term-toggle-mode)
                              (define-key term-raw-map (kbd "C-c C-k") 'term-toggle-mode)
                              ))

  ;; no line highlight in term mode
  (add-hook 'term-mode-hook (lambda ()
                              (setq-local global-hl-line-mode
                                          nil)))

  (bind-key "C-c C-z" 'term-stop-subjob)
  )
