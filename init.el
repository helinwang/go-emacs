(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(set-face-attribute 'region nil :background "#fffacd")

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq inhibit-splash-screen t)
;; (require 'bookmark)
;; (bookmark-bmenu-list)
;; (switch-to-buffer "*Bookmark List*")

(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "C--") 'undo)
(global-set-key (kbd "C-x g") 'magit-status)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  ;;(add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)


(require 'zenburn-theme)

(require 'use-package)
(setq use-package-always-ensure t)

(use-package ag)

(use-package helm-ag
  :after ag)

(use-package helm-projectile
  :after helm
  :config
  (helm-projectile-on))

(use-package diminish)

(use-package helm
  :diminish helm-mode
  :init
  (require 'helm-config)
  :bind
  ("C-c f" . helm-projectile-find-file-dwim)
  ("M-x" . helm-M-x)
  ("C-x r b" . helm-filtered-bookmarks)
  ("C-x C-f" . helm-find-files)
  :init
  (helm-mode 1)
  (customize-set-variable 'helm-ff-lynx-style-map t))

;; (require 'helm-config)
;; (global-set-key (kbd "M-x") #'helm-M-x)
;; (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
;; (global-set-key (kbd "C-x C-f") #'helm-find-files)
;; (helm-mode 1)

;; (require 'shackle)
;; (shackle-mode 1)
;; (setq shackle-rules '((compilation-mode :noselect t))
;;       shackle-default-rule '(:select t))

(global-set-key (kbd "C-c f") #'helm-projectile-find-file-dwim)
(global-set-key (kbd "C-c c") #'helm-projectile-ack)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :demand t
  :ensure t
  :bind
  ("M-<down>" . next-error)
  ("M-<up>" . previous-error)
  :init
  (global-flycheck-mode)
  (setq flycheck-standard-error-navigation nil))

(use-package flycheck-gometalinter
  :ensure t
  :config
  (progn
        (flycheck-gometalinter-setup)))
(use-package go-mode
  :ensure t)
(use-package auto-complete
  :ensure t)
(use-package go-eldoc
  :ensure t)
(use-package yasnippet
  :ensure t)

(add-to-list 'load-path "~/.emacs.d/go/")
(require 'go-guru)
(require 'go-rename)

(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save) ; gofmt before every save
  (setq gofmt-command "goimports")                ; gofmt uses invokes goimports
  (if (not (string-match "go" compile-command))   ; set compile command default
      (set (make-local-variable 'compile-command)
	   "go build -i -v"))

  ;; guru settings
  (go-guru-hl-identifier-mode)                    ; highlight identifiers

  ;; Key bindings specific to go-mode
  (local-set-key (kbd "M-d") 'go-guru-describe)
  (local-set-key (kbd "M-.") 'go-guru-definition) ; 'godef-jump)
  (local-set-key (kbd "M-,") 'pop-tag-mark)
  (local-set-key (kbd "C-c b") 'compile)            ; Invoke compiler
  ;; (local-set-key (kbd "M-P") 'recompile)          ; Redo most recent compile cmd
  (local-set-key (kbd "M-?") 'go-guru-referrers)
  (define-key input-decode-map "\e\eOA" [(meta up)])
  (define-key input-decode-map "\e\eOB" [(meta down)])
  (local-set-key [(meta down)] 'next-error)         ; Go to next error (or msg)
  (local-set-key [(meta up)] 'previous-error)     ; Go to previous error or msg  

  (go-eldoc-setup)

  ;; Misc go stuff
  (auto-complete-mode 1))                         ; Enable auto-complete mode

(add-hook 'go-mode-hook 'my-go-mode-hook)

;; Ensure the go specific autocomplete is active in go-mode.
(with-eval-after-load 'go-mode
  (require 'go-autocomplete)
  (require 'auto-complete-config)
  (ac-config-default))

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
                ))
(yas-global-mode 1)



(use-package highlight-symbol
  :hook (prog-mode . highlight-symbol-mode)
  :bind
  ("M-n" . highlight-symbol-next)
  ("M-p" . highlight-symbol-prev)
  :config
  (setq highlight-symbol-nav-mode t)
  (setq highlight-symbol-mode t)
  (setq highlight-symbol-idle-delay 0.3))

;; (require 'highlight-symbol)
;; (global-set-key (kbd "M-n") 'highlight-symbol-next)
;; (global-set-key (kbd "M-p") 'highlight-symbol-prev)

;; (defun my-hook ()
;;   (setq highlight-symbol-nav-mode t)
;;   (setq highlight-symbol-mode t)
;;   (setq highlight-symbol-idle-delay 0.3)
;; )
;; (add-hook 'after-change-major-mode-hook 'my-hook)

(setq flycheck-gometalinter-vendor t)
(setq flycheck-gometalinter-fast t)
(setq flycheck-gometalinter-disable-linters '("gotype"))
(setq flycheck-gometalinter-deadline "10s")
;; (setq flycheck-gometalinter-disable-all t)
;; (setq flycheck-gometalinter-enable-linters '("golint" "errcheck"))

;; go get -u golang.org/x/tools/cmd/...
;; go get -u github.com/rogpeppe/godef/...
;; go get -u github.com/nsf/gocode
;; go get -u golang.org/x/tools/cmd/goimports
;; go get -u golang.org/x/tools/cmd/guru
;; go get -u github.com/dougm/goflymake
;; go get -u github.com/alecthomas/gometalinter
;; gometalinter --install --update
;; go get -u golang.org/x/tools/cmd/gorename


(use-package ace-window
  :bind ("M-o" . ace-window))

(global-set-key (kbd "M-j") 'xref-find-definitions)

;; ;; Rust
;; ;; https://github.com/rust-lang/rust-mode
;; (add-to-list 'load-path "~/.emacs.d/rust/")
;; (autoload 'rust-mode "rust-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
;; (setq rust-format-on-save t)

;; https://github.com/flycheck/flycheck-rust
;; (require 'flycheck-rust)
;; (with-eval-after-load 'rust-mode
;;   (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; https://github.com/racer-rust/emacs-racer
;; (add-hook 'rust-mode-hook #'racer-mode)
;; (add-hook 'rust-mode-hook
;; 	  (lambda () (local-set-key (kbd "C-c r") #'rust-run)))
;; (add-hook 'racer-mode-hook #'eldoc-mode)
;; (add-hook 'racer-mode-hook #'company-mode)

;; (setq racer-rust-src-path
;;       (concat (string-trim
;;                (shell-command-to-string "rustc --print sysroot"))
;;               "/lib/rustlib/src/rust/src"))

;; (require 'rust-mode)
;; (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
;; (setq company-tooltip-align-annotations t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (zenburn)))
 '(package-selected-packages
   (quote
    (zenburn-theme yasnippet use-package highlight-symbol helm-projectile helm-ag go-eldoc flycheck-gometalinter diminish auto-complete ag ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
