;;;; File : gui.el
;;;; Settings for emacs when using window system

(unless (package-installed-p 'color-theme-solarized)
  (package-install 'color-theme-solarized))

;; themes settings
(defun default-theme-hook ()
  (add-to-list 'default-frame-alist '(background-color . "black"))
  (add-to-list 'default-frame-alist '(foreground-color . "white")))

(defun solarized-theme-hook ()
  (add-to-list 'default-frame-alist '(background-color . "black"))
  (load-theme 'solarized t))

;; osx-specific settings
(when (memq window-system '(mac ns))
  (add-to-list 'load-path "/Applications/Emacs.app")
  (exec-path-from-shell-initialize)
  (setq mac-option-modifier 'meta))

;; initialize emacs gui
(when (display-graphic-p)
  (set-default-font "DejaVu Sans Mono-12")
  (add-hook 'after-init-hook 'solarized-theme-hook))
