(use-package go-mode
  :defines (gofmt-command flycheck-mode whitespace-style)
  :init
  (setq gofmt-command "goimports")
  :hook
  ((go-mode . (lambda ()
                (flycheck-mode)
                (setq-local indent-tabs-mode t)
                (setq-local whitespace-style '(empty lines-tail trailing))
                (lsp)))
   (before-save . gofmt-before-save)))

(use-package company-go
  :after (company go-mode)
  :defines company-backends
  :config
  (eval-after-load 'company
    '(add-to-list 'company-backends 'company-go)))

(use-package go-rename
  :after (go-mode))

(use-package gotest
  :after (go-mode))

(use-package flycheck-gometalinter
  :after (flycheck go-mode)
  :init
  (setq flycheck-gometalinter-fast t
        flycheck-gometalinter-vendor t
        flycheck-gometalinter-enable-linters '("golint"))
  :config
  (flycheck-gometalinter-setup))

(provide 'init-go)
