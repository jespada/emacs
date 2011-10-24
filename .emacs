(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector [zenburn-bg zenburn-red zenburn-green zenburn-yellow zenburn-blue zenburn-magenta zenburn-cyan zenburn-fg])
 '(custom-enabled-themes (quote (wheatgrass)))
 '(custom-safe-themes (quote ("0174d99a8f1fdc506fa54403317072982656f127" "e9704e8b957e4151cd570c5f25ec81c297aa2b6a" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;EMACS-WIDE SETTINGS
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
;Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;;keep backup files in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(require 'tea-time)
(setq tea-time-sound "~/AFRAID.WAV")

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
