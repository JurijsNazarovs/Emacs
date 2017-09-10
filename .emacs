(add-to-list 'load-path "/Users/Owner/.emacs.d/cl-lib")
(require 'cl-lib)

;; Melpa - source to install packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
;;'("elpy" . "http://jorgenschaefer.github.io/packages/"))
;;(add-to-list 'package-archives '("melpa" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; Custom-set-variables was added by Custom. (Themes and etc)
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tangotango)))
 '(custom-safe-themes
   (quote
    ("5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" default)))
 '(global-flycheck-mode t)
 '(inhibit-startup-screen t)
 '(markdown-command "/usr/local/bin/pandoc")
 '(package-selected-packages
   (quote
    (py-autopep8 exec-path-from-shell flycheck elpy flymd markdown-mode tangotango-theme)))
 '(show-paren-mode t))

;; Font
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :family "DejaVu Sans Mono")))))


;;;; ==========================================================================
;;;; Mods and functions
;;;; =========================================================================

;; markdown-mode
;;  To make a preview of an html file, need to provide a path to pandoc -
;;  parser for markdown files


;; Yasnippet - complete syntax based on patterns of language
(add-to-list 'load-path "/Users/Owner/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; Nyan-mode
(add-to-list 'load-path "/Users/Owner/.emacs.d/plugins/nyan-mode")
(require 'nyan-mode)
(setq-default nyan-wavy-trail t)
(nyan-mode)

;; Camel-case function
(defun camelCase-to_underscores (start end)
  "Convert any string matching something like aBc to a_bc"
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char 1)
    (let ((case-fold-search nil))
      (while (search-forward-regexp "\\([a-z]\\)\\([A-Z]\\)\\([a-z]\\)" nil t)
        (replace-match (concat (match-string 1)
                               "_"
                               (downcase (match-string 2))
                               (match-string 3))
                       t nil)))))


;;;; =========================================================================
;;;; Different setting of windows
;;;; =========================================================================

(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Do not jump from buffer-menu in another window
(global-set-key "\C-x\C-b" 'buffer-menu)

;; Coping/moving files between dirmodes
;; If two dirs are open in a vertical mode, then pressing c in one dir,
;; will move it on another dir window. Press capital C to copy
(setq dired-dwim-target t)

;; Line number to display
(global-linum-mode t)

;; Wrap line in respect of last word
(global-visual-line-mode t)

;; Tab width
(setq-default indent-tabs-mode nil) ;no tabs, but spaces
;; Next following lines make sense just if tabs are used for indention,
;; i.e. t not nil
;;(setq tab-width 4)
(setq sh-basic-offset 2) ;2 spaces instead of tab for shell
(setq java-basic-offset 2) ;2 spaces instead of tab for c

;; Mark the column with white line
(add-to-list 'load-path "/Users/Owner/.emacs.d/plugins/")
(require 'fill-column-indicator)

;; Settings for the line
(setq-default fci-rule-column 80) ;column to start line
(setq fci-rule-use-dashes 1)
(setq fci-rule-width 2)
(setq fci-rule-color "white")
(setq fci-dash-pattern 0.75) ;gaps between dashes

;; Add vertical line (margin) to programming modes
(add-hook
 'prog-mode-hook (lambda () (fci-mode 1))
 )

;; Add vertical line (margin) to text  modes
(add-hook
 'text-mode-hook (lambda () (fci-mode 1))
 )

;; Do not add << EOF when type <<<
(add-hook 'sh-mode-hook (lambda () (sh-electric-here-document-mode -1)))

;; Do not keep colors when yank - Does not work
(add-to-list 'yank-excluded-properties 'font)
(add-to-list 'yank-excluded-properties 'font-lock-face)

;;;; ==========================================================================
;;;; Programming part
;;;; ==========================================================================
;; Copy $PATH from terminal
(exec-path-from-shell-initialize)

;;; ================================
;;; Hook modes to extension of files
;;; ================================
;; Make Text mode the default mode for new buffers.
(setq-default major-mode 'text-mode)

;; Java mode
(add-to-list
 'auto-mode-alist '("\\.bds\\'" . java-mode)
 )

;;; ================================
;;; ESS - package for statistics
;;; ================================
(add-to-list 'load-path "/Users/Owner/.emacs.d/plugins/ESS/lisp/")
(load "ess-site")

;; R mode
;;(setq inferior-R-program-name "/usr/local/bin/R")

;;; ================================
;;; ELPY - IDE for python
;;; ================================
(elpy-enable)
;; python version for elpy
(setq elpy-rpc-python-command "/usr/local/bin/Python3")
;; python version for interactive shell
(setq python-shell-interpreter "/usr/local/bin/Python3")
;; Turn off warning message about python has no realine tool
(setq python-shell-completion-native-enable nil)
;; Correct Python code style according to pep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;; ================================
;;; On-the-fly syntax checking
;;; ================================
;; Checking code syntax
(global-flycheck-mode)
;; Checking spelling
(setq ispell-program-name "/usr/local/bin/aspell")
(setq ispell-dictionary "en_GB")


