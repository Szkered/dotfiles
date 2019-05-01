;;; packages.el --- my-org layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: zekun <zekun@zekun-AERO-15XV8>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq my-org-packages '(org))

(defun my-org/post-init-org ()

  (setq org-image-actual-width nil)

  (setq org-highlight-latex-and-related '(latex script entities))

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

  ;; key map
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "I" 'org-clock-in)
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "O" 'org-clock-out)
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "R" 'org-refile)
  (evil-define-key 'normal org-mode-map (kbd "<backtab>") 'org-global-cycle)
  (evil-define-key 'normal org-mode-map "t" 'org-todo)
  (evil-define-key 'normal org-mode-map "K" 'osx-dictionary-search-word-at-point)

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

  (setq org-lowest-priority ?D)
  (setq org-highest-priority ?A)

  (setq org-agenda-custom-commands
        '(
          ("d" "Daily agenda and all TODOs"
           (
            (tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "Doing it Now:")))
            (tags "PRIORITY=\"B\""
                  ((org-agenda-skip-function '(or (org-agenda-skip-entry-if 'todo 'done)
                                                  (org-agenda-skip-entry-if 'todo '("RUNWAY" "HANGER"))))
                   (org-agenda-overriding-header "Long Term:")))
            (tags "PRIORITY=\"D\""
                  ((org-agenda-skip-function '(or (org-agenda-skip-entry-if 'todo 'done)
                                                  (org-agenda-skip-entry-if 'todo '("RUNWAY" "HANGER"))))
                   (org-agenda-overriding-header "Learning:")))
            (tags "TODO=\"AIRBORNE\""
                  ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                  (air-org-skip-subtree-if-priority ?A)
                                                  (air-org-skip-subtree-if-priority ?B)
                                                  (air-org-skip-subtree-if-priority ?D)))
                   (org-agenda-overriding-header "AIRBORNE projects:")))
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

  (setq org-agenda-block-separator (string-to-char " "))

  (setq org-format-latex-options (plist-put org-format-latex-options :scale 3.0))
  )
