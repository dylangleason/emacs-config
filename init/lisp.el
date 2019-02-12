;;; Basic Lisp / ELisp packages and configurations

(use-package paredit)
(use-package rainbow-delimiters)

(defun prettify-lambda ()
  (setq prettify-symbols-alist '(("lambda" . 955))))

(defun my-lisp-mode-common-hook ()
  (paredit-mode t)
  (prettify-lambda)
  (rainbow-delimiters-mode-enable))

(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-common-hook)
(add-hook 'lisp-mode-hook 'my-lisp-mode-common-hook)
(add-hook 'lisp-interaction-mode-hook 'my-lisp-mode-common-hook)

;;; Setup SBCL and slime, assuming slime is installed

(when (file-exists-p "~/quicklisp/slime-helper.el")
  (load (expand-file-name "~/quicklisp/slime-helper.el"))
  (require 'slime)
  (setq inferior-lisp-program "/usr/local/bin/sbcl")
  (setq slime-protocol-version 'ignore)
  (slime-setup '(slime-repl slime-asdf slime-fancy slime-banner))
  (add-hook 'slime-mode-hook (paredit-mode t)))

;;; Setup Clojure and CIDER

(defun my-cider-repl-mode-hook ()
  (setq-local nrepl-hide-special-buffers t)
  (setq-local cider-repl-display-help-banner nil)
  (eldoc-mode))

(use-package clojure-mode
  :after (paredit)
  :hook (clojure-mode . my-lisp-mode-common-hook))

(use-package cider
  :after (clojure-mode)
  :hook ((cider-mode . my-lisp-mode-common-hook)
         (cider-repl-mode . my-cider-repl-mode-hook)))

(defadvice 4clojure-open-question (around 4clojure-open-question-around)
  "Start a cider/nREPL connection if one hasn't already been
  started when opening 4clojure questions"
  ad-do-it
  (unless cider-current-clojure-buffer
    (cider-jack-in)))

;;; Configure Scheme / Racket

(use-package geiser
  :after (scheme paredit))

(defun my-scheme-mode-hook ()
  (my-lisp-mode-common-hook)
  (setq geiser-chez-binary "/usr/local/bin/chez"
        geiser-guile-binary "/usr/local/bin/guile"
        geiser-active-implementations '(chez chicken guile)
        geiser-repl-history-filename "~/.emacs.d/geiser-history"))

(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)
