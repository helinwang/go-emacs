### Usage

If you have never configured emacs, you can just do:
```bash
git clone git@github.com:helinwang/go-emacs.git ~/.emacs.d
```

Hotkeys:
```
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
```
iferr:

if err != nil {

}
```
