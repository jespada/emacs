(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("e81c9d66abd76f81009e2843e655cb4c3ae46cfd42b27471520d8eed748fcb23" "117284df029007a8012cae1f01c3156d54a0de4b9f2f381feab47809b8a1caef" "5debeb813b180bd1c3756306cd8c83ac60fda55f85fb27249a0f2d55817e3cab" default)))
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/estimadores-lect1.org"))))
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
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")


;;Copy/paste fix
(setq x-select-enable-clipboard t)

;;Default theme
;;(load-theme 'solarized-dark)
(load-theme 'zenburn)

;;Marmalade Repo
(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

;;keep backup files in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;=== Tea Time ===
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

;; enable for all programming modes
(add-hook 'prog-mode-hook 'subword-mode)

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
;;REPL
;;(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
;;(autoload 'inf-ruby-keys "inf-ruby" "" t)
;;(eval-after-load 'ruby-mode
;;'(add-hook 'ruby-mode-hook 'inf-ruby-keys))

(require 'inf-ruby)
(autoload 'run-ruby "inf-ruby"
          "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
          "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
          (inf-ruby-keys)
          ))

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Cheffile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Kitchenfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Kitchenfile$" . ruby-mode))
(require 'ruby-block)
(ruby-block-mode t)

(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)



;; Setting rbenv path (http://marc-bowes.com/2012/03/10/rbenv-with-emacs.html)
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

;;RVM - use rvm's default ruby for the current Emacs session
(require 'rvm)
(rvm-use-default)

;;=== camelCase Words ===
(global-subword-mode 1)


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

;; Completion will never be started automatically.
;;(setq ac-auto-start nil)

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

;;=== highlight-indentation ===
(require 'highlight-indentation)

;;=== Chef-Mode ===
(require 'chef-mode)


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
