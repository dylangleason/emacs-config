;;;; File: web-mode.el
;;;; web-mode customizations

(unless (package-installed-p 'web-mode)
  (package-install 'web-mode))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun my-web-mode-hook ()
  (setq web-mode-css-indent-offset 4
        web-mode-code-indent-offset 4
        web-mode-markup-indent-offset 4
        web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  (add-hook 'before-save-hook (lambda () (untabify (point-min) (point-max)))))

(add-hook 'web-mode-hook 'my-web-mode-hook)
