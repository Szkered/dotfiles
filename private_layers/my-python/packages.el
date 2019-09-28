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

  (add-to-list 'load-path "~/.emacs.d/nei/emacs")
  (require 'nei)


  ;; lsp is currently too heavy for me
  ;; (require 'lsp-mode)

  (add-hook 'python-mode-hook (lambda ()
                                (require 'pyvenv)
                                (pyvenv-workon "tf14")
                                (flycheck-mode 1)
                                (semantic-mode 1)
                                ;; (lsp)
                                ;; (lsp-mode 1)
                                ))

  ;; dap
  (require 'dap-ui)
  (require 'dap-python)
  (spacemacs/set-leader-keys-for-major-mode 'python-mode "db" nil)
  (spacemacs/set-leader-keys-for-major-mode 'python-mode "dB" 'spacemacs/python-toggle-breakpoint)
  (spacemacs/dap-bind-keys-for-mode 'python-mode)
  (spacemacs/set-leader-keys-for-major-mode 'python-mode "dt" 'dap-debug-edit-template)

  (dap-register-debug-template "Python :: bt_env_runner"
                               (list :type "python"
                                     :args "-c precog/configs/bt_env_ppo.gin -n ppo_walk_parallel -r walk -p -use-shm"
                                     :cwd "~/workspace/precog"
                                     :target-module nil
                                     :request "launch"
                                     :name "Python :: bt_env_runner"))

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
    (spacemacs/python-start-or-switch-repl))

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
