;;; early-init.el --- Early init -*- lexical-binding: t; no-byte-compile: t -*-
(setq package-enable-at-startup nil)
(setq user-emacs-directory (expand-file-name "~/.config/emacs/"))

;; Frame parameters for Mac port
(setq default-frame-alist
      '((font . "MesloLGM Nerd Font-18")
        (vertical-scroll-bars . nil)
        (tool-bar-lines . 0)
        (menu-bar-lines . 0)))
(setq initial-frame-alist default-frame-alist)

;; Font fallback for daemon/clients
(add-hook 'emacs-startup-hook
  (lambda ()
    (set-face-attribute 'default nil :font "MesloLGM Nerd Font" :height 160 :weight 'medium)
    (set-face-attribute 'variable-pitch nil :font "MesloLGM Nerd Font" :height 160 :weight 'medium)
    (set-face-attribute 'fixed-pitch nil :font "MesloLGM Nerd Font" :height 160 :weight 'medium)
    (set-face-attribute 'font-lock-comment-face nil :slant 'italic)
    (set-face-attribute 'font-lock-keyword-face nil :slant 'italic)))

