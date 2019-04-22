;;; packages.el --- my-haskell layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: zekun <zekun@zekun-AERO-15XV8>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq my-haskell-packages '(intero haskell))

(defun my-haskell/post-init-haskell ()

  ;;(add-to-list 'tramp-remote-path "~/.local/bin") ;; intero over tramp

  (let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
    (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
    (add-to-list 'exec-path my-cabal-path))

  (custom-set-variables '(haskell-tags-on-save t))

  (setq haskell-hoogle-command nil)

  (evil-define-key 'normal haskell-mode-map "K" 'haskell-hoogle-lookup-from-local)

  (add-hook 'haskell-mode-hook 'structured-haskell-mode)
  (add-hook 'haskell-mode-hook 'intero-mode)

  (setq intero-global-mode 1)

  ;; (setq intero-whitelist '("~/prog/quorum-tools" "~/prog/constellation"))
  ;; (setq intero-blacklist '("~/prog/Learning-Haskell"))

  (add-hook 'haskell-mode-hook (lambda ()
                                 (define-key haskell-mode-map (kbd "M-[") 'intero-goto-definition)
                                 (define-key haskell-mode-map (kbd "C-M-;") 'comment-dwim)
                                 (add-hook 'completion-at-point-functions 'intero-repl-completion-at-point)
                                 ))
  (add-hook 'haskell-mode-hook (if intero-mode
                                   (progn
                                     (add-hook 'completion-at-point-functions 'intero-repl-completion-at-point)
                                     )))
  (spacemacs/set-leader-keys-for-major-mode 'haskell-mode "S" 'structured-haskell-mode)

  )

;;; packages.el ends here
