### Install

1. Backup your `~/.emacs` file and `~/.emacs.d` directory, and clone this repo to be your `~/.emacs.d`.
   ```bash
   mv ~/.emacs ~/.emacs.bak
   mv ~/.emacs.d ~/.emacs.d.bak
   git clone https://github.com/helinwang/go-emacs ~/.emacs.d
   ```
   
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
  (local-set-key (kbd "M-d") 'go-guru-describe)
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
