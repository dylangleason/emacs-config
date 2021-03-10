(use-package python
  :defines (flycheck-mode flycheck-disabled-checkers)
  :hook (python-mode . flycheck-mode)
  :init
  (setq flycheck-disabled-checkers '(python-pylint)
        python-shell-interpreter "ipython"
        python-shell-interpreter-args "--simple-prompt -c exec('__import__(\\'readline\\')') -i")
  :mode ("\\.py\\'" . python-mode))

(use-package py-test
  :after (python))

(use-package elpy
  :defer t
  :defines (elpy-shell-echo-output)
  :init
  (setq elpy-shell-echo-output nil)
  (advice-add 'python-mode :before 'elpy-enable))

(use-package poetry
  :after (python))

(use-package hy-mode
  :after (python)
  :hook (hy-mode . my-lisp-mode-common-hook)
  :mode ("\\.hy\\'" . hy-mode))

(provide 'init-python)
