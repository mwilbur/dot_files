;;;; dired
(with-eval-after-load 'dired
  ;; Not create new buffer, if you chenge directory in dired
  (put 'dired-find-alternate-file 'disabled nil)

  (when (executable-find "gls")
    (setq insert-directory-program "gls"))

  (load-library "ls-lisp")

  ;; binding
  (define-key dired-mode-map (kbd "K") 'dired-k)
  (define-key dired-mode-map (kbd "i") 'dired-subtree-insert)
  (define-key dired-mode-map (kbd "I") 'dired-subtree-remove)
  (define-key dired-mode-map (kbd "C-M-u") 'dired-up-directory)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode))

(custom-set-variables
 '(ls-lisp-dirs-first t)
 '(dired-dwim-target t)
 '(dired-auto-revert-buffer t)
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'always))

(autoload 'dired-jump "dired-x" nil t)
(global-set-key (kbd "C-x C-j") 'dired-jump)
