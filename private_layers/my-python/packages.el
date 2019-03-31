;;; packages.el --- my-python layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: zekun <zekun@zekun-AERO-15XV8>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq my-python-packages
  '(python)
)

(defun my-python/post-init-python ()
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
  )
