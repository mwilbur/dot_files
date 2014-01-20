;; shellscript mode
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

;; compilation
(custom-set-variables
 '(compilation-message-face nil))

(eval-after-load "compile"
  '(progn
     (set-face-attribute 'compilation-error nil :underline nil)
     (set-face-attribute 'compilation-line-number nil :underline t)))

;; eshell
(eval-after-load "em-prompt"
  '(progn
     (set-face-attribute 'eshell-prompt nil
                         :foreground "yellow")))

(defun my/eshell-first-time-load-hook ()
  (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history)
  (setq eshell-first-time-p nil))
(add-hook 'eshell-first-time-mode-hook 'my/eshell-first-time-load-hook)

(defvar eshell-pop-buffer "*eshell-pop*")
(defvar eshell-prev-buffer nil)

(defun eshell-chdir (dir)
  (eshell-kill-input)
  (insert dir)
  (eshell-send-input))

(defun eshell-pop ()
  (interactive)
  (let ((curdir default-directory))
    (setq eshell-prev-buffer (current-buffer))
    (unless (get-buffer eshell-pop-buffer)
      (save-window-excursion
        (pop-to-buffer (get-buffer-create eshell-pop-buffer))
        (eshell-mode)))
    (popwin:popup-buffer (get-buffer eshell-pop-buffer) :height 20 :stick t)
    (unless (string= default-directory curdir)
      (eshell-chdir curdir))))
(global-set-key (kbd "M-g M-s") 'eshell-pop)

(defun eshell/cde ()
  (let* ((file-name (buffer-file-name eshell-prev-buffer))
         (dir (or (and file-name (file-name-directory file-name))
                  (and (eq major-mode 'dired-mode) dired-directory)
                  (with-current-buffer eshell-prev-buffer
                    default-directory))))
    (eshell/cd dir)))

(defun eshell/cdp ()
  (let ((dir (cl-loop with cwd = default-directory
                      for d in '(".git" ".hg" ".svn")
                      when (locate-dominating-file cwd d)
                      return (file-name-directory it))))
    (eshell/cd dir)))

(defun eshell/e (file)
  (let ((curwin (get-buffer-window))
        (filepath (concat default-directory file)))
    (other-window 1)
    (find-file filepath)
    (delete-window curwin)))
