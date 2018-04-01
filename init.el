(menu-bar-mode -1)

(global-set-key "\M-g" 'goto-line)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(add-to-list 'load-path "~/.emacs.d/misc/")
(require 'popwin)
(popwin-mode 1)
(global-set-key (kbd "C-z") popwin:keymap)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
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
	   "go install -i -v && go test -v && go vet"))

  ;; guru settings
  (go-guru-hl-identifier-mode)                    ; highlight identifiers

  ;; Key bindings specific to go-mode
  (local-set-key (kbd "M-d") 'go-guru-describe)
  (local-set-key (kbd "M-.") 'godef-jump) ;'go-guru-definition)
  (local-set-key (kbd "M-,") 'pop-tag-mark)
  (local-set-key (kbd "M-p") 'compile)            ; Invoke compiler
  (local-set-key (kbd "M-P") 'recompile)          ; Redo most recent compile cmd
  (local-set-key (kbd "M-]") 'next-error)         ; Go to next error (or msg)
  (local-set-key (kbd "M-[") 'previous-error)     ; Go to previous error or msg

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
