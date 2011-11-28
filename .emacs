(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes (quote ("2929c912071f6f2d7ae8164a7fb2fd1c992a0d6a" "5600dc0bb4a2b72a613175da54edb4ad770105aa" "0174d99a8f1fdc506fa54403317072982656f127" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;EMACS-WIDE SETTINGS
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
;;Themes
(add-to-list 'load-path "~/.emacs.d/emacs-color-theme-solarized/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized-dark)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")


;;keep backup files in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(require 'tea-time)
;;(setq tea-time-sound "~/AFRAID.WAV")

;; ===== Turn off tab character =====

;;
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request this,
;; set `indent-tabs-mode' to `nil'. This is a per-buffer variable;
;; altering the variable affects only the current buffer, but it can be
;; disabled for all buffers.

;;
;; Use (setq ...) to set value locally to a buffer
;; Use (setq-default ...) to set value globally
;;
(setq-default indent-tabs-mode nil)


;; ===== Adjusting the Basic Indentation Width Used in Code =====
(setq-default c-basic-offset 4)

;; Java Indentation
(defun my-java-mode-hook ()
  (setq c-basic-offset 4))
(add-hook 'java-mode-hook 'my-java-mode-hook)

;; Python Indentation
(setq-default py-indent-offset 4)

;; Ruby Indentation
(defun my-ruby-mode-hook ()
  (setq c-basic-offset 2))
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)




;;show column markers
(require 'column-marker)
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))
(add-hook 'ruby-mode-hook (lambda () (interactive) (column-marker-1 80)))
(add-hook 'java-mode-hook (lambda () (interactive) (column-marker-1 80)))
;;toggle column 80 marker

;; See matching parens
(show-paren-mode t)

;; Whitespace
(require 'whitespace)
(autoload 'whitespace-mode "whitespace" "Toggle whitespace visualization." t)
(autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; make completion buffers disappear after 12 seconds.
(add-hook 'completion-setup-hook
  (lambda () (run-at-time 12 nil
    (lambda () (delete-windows-on "*Completions*")))))


;;===== Auto complete Mode ======
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

;; start completion when entered 3 characters
(setq ac-auto-start 3)

;; Completion will never be started automatically.                                                                                                                    ;;(setq ac-auto-start nil)

;;=== EMACS PERFORMANCE ===
;; re-draw display before accept new imput (not recommended for old computers)
;;(setq redisplay-dont-pause t)
(blink-cursor-mode -1)
;;=== EMACS MINIMALIST ===
(menu-bar-mode -1) (tool-bar-mode -1) (scroll-bar-mode -1)

;;=== Interactively Do Things ===
;;Ido Mode
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;;==== KEY BINDINGS ====
;;skip to line number
;;(global-set-key "\C-Xg" 'goto-line)(no need I have: M-g g)

;; F12 to run eshell
(global-set-key (kbd "<f12>") 'eshell)

;;Google Search - from prelude-google
(defun google-search ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google: ")))))

;;DuckDuckgo search
(defun duckduckgo-search (text)
  "Search DuckDuckGo from Emacs."
  (interactive "sSearch: ")
  (browse-url
   (concat "https://duckduckgo.com/?q="
           (replace-regexp-in-string " " "+" text))))
