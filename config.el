(setq major-mode-remap-alist
      '((python-ts-mode . python-mode)
        (c-ts-mode      . c-mode)
        (c++-ts-mode    . c++-mode)
        (js-ts-mode     . js-mode)))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
  ;; Assume :elpaca t unless otherwise specified.
  (setq elpaca-use-package-by-default t))

;; Block until current queue processed.
(elpaca-wait)

;;When installing a package which modifies a form used at the top-level
;;(e.g. a package which adds a use-package key word),
;;use `elpaca-wait' to block until that package has been installed/configured.
;;For example:
;;(use-package general :demand t)
;;(elpaca-wait)

;; Expands to: (elpaca evil (use-package evil :demand t))
;; Evil mode - properly structured
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  :config
  (evil-mode))

;; Evil collection - separate use-package block
(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer calendar))
  (evil-collection-init))

;; Evil tutor - separate block
(use-package evil-tutor)
;;Turns off elpaca-use-package-mode current declartion
;;Note this will cause the declaration to be interpreted immediately (not deferred).
;;Useful for configuring built-in emacs features.

(use-package emacs
  :ensure nil
  :config
  (setq ring-bell-function #'ignore))

;; Don't install anything. Defer execution of BODY
(defun reload-init-file ()
  (interactive)
  (load-file user-init-file)
  (load-file user-init-file))
(defun close-most-recent-window ()
  "Close the most recently used window regardless of buffer content."
  (interactive)
  (let ((recent-win (next-window)))
    (when (not (one-window-p))
      (select-window recent-win)
      (kill-buffer (window-buffer recent-win))
      (delete-window)
      (other-window -1))))


(use-package general
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer dt/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (dt/leader-keys
    "b" '(:ignore t :wk "buffer")
    "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b k" '(kill-this-buffer :wk "Kill this buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer"))

    (dt/leader-keys
    "e" '(:ignore t :wk "Evaluate")    
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region")) 

    (dt/leader-keys
    "." '(find-file :wk "Find file")
    "f c" '((lambda () (interactive) (find-file "~/.config/emacs/config.el")) :wk "Edit emacs config")
    "f r" '(consult-recent-file :wk "Find recent files")
    "g c" '(comment-line :wk "Comment lines"))

    (dt/leader-keys
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    ;;"h r r" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config"))
    "h r r" '((lambda () (interactive)
		    (load-file "~/.config/emacs/init.el")
		    (ignore (elpaca-process-queues)))
		:wk "Reload emacs config")
    "h b" '(describe-bindings :wk "Describe bindings")
    "h L" '(describe-language-environment :wk "Describe language environment")
    )
    ;; "h r r" '(reload-init-file :wk "Reload emacs config"))

  (dt/leader-keys
    "w" '(:ignore t :wk "Windows")
    ;; Window splits
    "w c" '(evil-window-delete :wk "Close window")
    "w q" '(close-most-recent-window :wk "Close recent window") ;;function declared above
    ;;"w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    ;; Window motions
     "w n" '(evil-window-left :wk "Window left")
     "w e" '(evil-window-down :wk "Window down")
     "w i"   '(evil-window-up :wk "Window up")
     "w o" '(evil-window-right :wk "Window right")
     "w w"     '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "w N"  '(buf-move-left :wk "Buffer move left")
    "w E"  '(buf-move-down :wk "Buffer move down")
    "w I"    '(buf-move-up :wk "Buffer move up")
    "w o"    '(buf-move-right :wk "Buffer move right"))

  (dt/leader-keys
  ":" '(execute-extended-command :wk "M-x"))
   ;; "w <right>" '(buf-move-right :wk "Buffer move right"))


  (dt/leader-keys
    "o" '(:ignore t :wk "Open")
    "o t" '(vterm-toggle :wk "open vterm"))

    (dt/leader-keys
    "p" '(:ignore t :wk "projectile")
    "p f" '(projectile-find-file :wk "Find file")
    "p p" '(projectile-switch-project :wk "Switch project")
    "p a" '(projectile-add-known-project :wk "Add to projects")
    "p d" '(projectile-remove-known-project :wk "Remove project")
    "p s g" '(projectile-grep :wk "Grep in project")
    "p k" '(projectile-kill-buffers :wk "Kill project buffers")
    "p v" '(dired-jump :wk "Open dired in current dir"))

(dt/leader-keys
  "g" '(:ignore t :wk "Git")
  "g s" '(magit-status :wk "Magit status")
  "g b" '(magit-branch :wk "Branch")
  "g f" '(magit-fetch :wk "Fetch")
  "g p" '(magit-push :wk "Push")
  "g P" '(magit-pull :wk "Pull")
  "g l" '(magit-log :wk "Log")
  "g d" '(magit-diff :wk "Diff")
  "g c" '(magit-commit :wk "Commit"))



)

(require 'windmove)
;;;###autoload
(defun buf-move-up ()
  "Swap the current buffer and the buffer above the split.
If there is no split, ie now window above the current one, an
error is signaled."
;;  "Switches between the current buffer, and the buffer above the
;;  split, if possible."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'up))

	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No window above this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-down ()
"Swap the current buffer and the buffer under the split.
If there is no split, ie now window under the current one, an
error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'down))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (or (null other-win) 
            (string-match "^ \\*Minibuf" (buffer-name (window-buffer other-win))))
        (error "No window under this one")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-left ()
"Swap the current buffer and the buffer on the left of the split.
If there is no split, ie now window on the left of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'left))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No left split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))

;;;###autoload
(defun buf-move-right ()
"Swap the current buffer and the buffer on the right of the split.
If there is no split, ie now window on the right of the current
one, an error is signaled."
  (interactive)
  (let* ((other-win (windmove-find-other-window 'right))
	 (buf-this-buf (window-buffer (selected-window))))
    (if (null other-win)
        (error "No right split")
      ;; swap top with this one
      (set-window-buffer (selected-window) (window-buffer other-win))
      ;; move this one to top
      (set-window-buffer other-win buf-this-buf)
      (select-window other-win))))


(set-face-attribute 'default nil
  :font "MesloLGM Nerd Font"
  :height 160
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "MesloLGM Nerd Font"
  :height 160
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "MesloLGM Nerd Font"
  :height 160
  :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "MesloLGM Nerd Font"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package which-key
  :init
    (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
	which-key-sort-order #'which-key-key-order-alpha
	which-key-sort-uppercase-first nil
	which-key-add-column-padding 1
	which-key-max-display-columns nil
	which-key-min-display-lines 6
	which-key-side-window-slot -10
	which-key-side-window-max-height 0.25
	which-key-idle-delay 0.8
	which-key-max-description-length 25
	which-key-allow-imprecise-window-fit t
	which-key-separator " → " ))


(use-package sudo-edit
  :config
    (dt/leader-keys
      "fu" '(sudo-edit-find-file :wk "Sudo find file")
      "fU" '(sudo-edit :wk "Sudo edit file")))

(use-package vertico
  :init
  (vertico-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :bind (("C-x b" . consult-buffer)
         ("C-c C-r" . consult-recent-file)))
(use-package eshell-syntax-highlighting 
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
;; eshell-aliases-file -- sets an aliases file for the eshell.
  
(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "htop" "ssh" "top" "zsh" ))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode)
  ;; If you have use-package-hook-name-suffix set to nil, uncomment and use the
  ;; line below instead:
  ;; :hook (eshell-mode-hook . esh-autosuggest-mode)
  :ensure t)

(use-package rainbow-mode
  :hook 
  ((org-mode prog-mode) . rainbow-mode))

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(load-theme 'theme t)


(use-package projectile
  :config
  (projectile-mode 1)
  (setq projectile-switch-project-action #'projectile-dired)
  (setq projectile-project-root-files-bottom-up '(".projectile" ".git" ".hg" ".svn"))
  (setq projectile--mode-line "Projectile"))

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Breathe....")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.config/emacs/images/avatar.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 3)
                          (projects . 3)))
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))


(use-package diminish
  :config
  (diminish 'eldoc-mode)
  (diminish 'visual-line-mode)
  (diminish 'which-key-mode)
  (diminish 'projectile-mode))

(use-package transient
  :ensure t
  :demand t)

(use-package magit
  :ensure t
  :commands magit-status
  :bind ("C-x g" . magit-status)
  :init
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

(use-package hl-todo
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

(global-set-key [escape] 'keyboard-escape-quit)
(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed

(use-package tramp
  :config
  (setq tramp-inline-compress-start-size 1000
        tramp-copy-size-limit 10000
        vc-handled-backends '(Git)
        tramp-verbose 1
        tramp-default-method "scp"
        tramp-use-ssh-controlmaster-options nil))

(use-package daemons)

(use-package proced
  :ensure nil
  :commands proced
  :bind (("C-M-p" . proced))
  :custom
  (proced-auto-update-flag t)
  (proced-goal-attribute nil)
  (proced-show-remote-processes t)
  (proced-enable-color-flag t)
  (proced-format 'custom)
  :config
  (add-to-list
   'proced-format-alist
   '(custom user pid ppid sess tree pcpu pmem rss start time state (args comm))))

(setq daemons-always-sudo t)
(use-package journalctl
  :ensure t
  (:host github 
           :repo "WJCFerguson/journalctl" 
           :files ("journalctl.el")))

;; (use-package treesit-auto
;;   :custom
;;   (treesit-auto-install 'prompt)
;;   :config
;;   (treesit-auto-add-to-auto-mode-alist 'all)
;;   (global-treesit-auto-mode))
;; Disable all treesit mode remapping
(setq treesit-auto-mode nil)
(setq major-mode-remap-alist nil)
;; Force python-mode instead of python-ts-mode
(setq treesit-load-symlinks nil)
(setq treesit-extra-load-path nil)

(use-package peep-dired
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
    (evil-define-key 'normal dired-mode-map (kbd "<left>") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "<right>") 'dired-find-file) ; use dired-find-file instead if not using dired-open package
    (evil-define-key 'normal peep-dired-mode-map (kbd "<down>") 'peep-dired-next-file)
    (evil-define-key 'normal peep-dired-mode-map (kbd "<up>") 'peep-dired-prev-file)
)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 20      ;; sets modeline height
        doom-modeline-bar-width 5    ;; sets right bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon t)) ;; adds folder icon next to persp name
(setq backup-directory-alist '((".*" . "/tmp/")))

(use-package nix-mode
  :mode "\\.nix\\'")

