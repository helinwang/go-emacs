### Install

1. Put the content of this repo to `~/.emacs.d`
1. Run following commands:
```bash
go get -u golang.org/x/tools/cmd/...
go get -u github.com/rogpeppe/godef/...
go get -u github.com/nsf/gocode
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/guru
go get -u github.com/dougm/goflymake
go get -u github.com/alecthomas/gometalinter
gometalinter --install --update
go get -u golang.org/x/tools/cmd/gorename
```

### Usage

Hotkeys:
```lisp
  (local-set-key (kbd "C-c C-j") 'go-guru-definition)
  (local-set-key (kbd "C-c C-d") 'go-guru-describe)
  (local-set-key (kbd "M-.") 'go-guru-definition)
  (local-set-key (kbd "M-,") 'pop-tag-mark)
  (local-set-key (kbd "M-p") 'compile)            ; Invoke compiler        
  (local-set-key (kbd "M-P") 'recompile)          ; Redo most recent compile cmd       
  (local-set-key (kbd "M-]") 'next-error)         ; Go to next error (or msg)       
  (local-set-key (kbd "M-[") 'previous-error)     ; Go to previous error or msg   
```

Snippets (triggered with tab):
```text
iferr:

if err != nil {

}
```
