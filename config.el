(add-hook 'window-setup-hook 'toggle-frame-maximized t)
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

;; Startup timer
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;;(set-face-attribute 'default nil :font "Fira Code Retina" :height 110)
(set-face-attribute 'default nil
:font "IBM Plex Mono"
:height 110)

;;(load-theme 'tango-dark)
;;(load-theme 'solarized-dark t)
(load-theme 'spacemacs-dark t)
(setq visible-bell t)

(setq sentence-end-double-space nil)

(global-set-key (kbd "C-c a") 'org-agenda)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(global-visual-line-mode t)

(defun no-despliegues ()
  (display-line-numbers-mode -1)
)
(add-hook 'org-mode-hook 'no-despliegues)
;;(add-hook 'text-mode-hook 'no-despliegues)
(add-hook 'markdown-mode-hook 'no-despliegues)
(add-hook 'eshell-mode-hook 'no-despliegues)
(add-hook 'dired-mode-hook 'no-despliegues)

;; El navegador por default es firefox
(setq browse-url-browser-function 'browse-url-firefox)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))

(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'emmet-mode)

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

(require 'darkroom)

(add-to-list 'load-path "~/.emacs.d/lisp/toc-org")
(if (require 'toc-org nil t)
    (progn
      (add-hook 'org-mode-hook 'toc-org-mode))
      ;; enable in markdown, too
      ;;(add-hook 'markdown-mode-hook 'toc-org-mode)
      ;;(define-key markdown-mode-map (kbd "\C-c\C-o") 'toc-org-markdown-follow-thing-at-point))
  (warn "toc-org not found"))

;;(require 'org-superstar) <- En caso de no tenerlo instalado.
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(setq org-startup-indented t)

(require 'lorem-ipsum)

(use-package counsel
  :ensure t
)
(use-package swiper
  :ensure try
  :config
  (progn
  (ivy-mode)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; enable this if you want `swiper' to use it
  ;; (setq search-default-mode #'char-fold-to-regexp)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
  ))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(add-to-list 'load-path "~/.emacs.d/lisp/emms")
(require 'emms-setup)
  (emms-all)
  (emms-default-players)
  (setq emms-source-file-default-directory "~/Music/") ;; Change to your music folder

(move-text-default-bindings)

(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

(set-fontset-font t 'symbol (font-spec :family "Noto Color Emoji") nil 'prepend)
(use-package emojify
  :config
  (when (member "Noto Color Emoji" (font-family-list))
    (set-fontset-font
     t 'symbol (font-spec :family "Noto Color Emoji") nil 'prepend))
  (setq emojify-display-style 'unicode)
  (setq emojify-emoji-styles '(unicode))
  (bind-key* (kbd "C-c .") #'emojify-insert-emoji)) ; override binding in any mode

(setq org-capture-templates
      '(("t" "Tarea" entry (file+headline "~/Documentos/org-mode/tareas.org" "Tareas")
         "* TODO %?\n  %i\n  %a")
        ("n" "Nota" entry (file+headline "~/Documentos/org-mode/notas.org" "Notas")
         "* %?\n  %i\n  %a")))

(global-set-key (kbd "C-c c") 'org-capture)

(set-frame-parameter (selected-frame) 'alpha '(100 . 100))
 (add-to-list 'default-frame-alist '(alpha . (100 . 100)))
