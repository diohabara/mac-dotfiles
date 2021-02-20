;;; package --- This is for the configuration
;;; Commentary:
;;; Code:

(setq user-full-name "Kadoi Takemaru"
      user-mail-address "diohabara@gmail.com")

(setenv "PATH" (concat "/Library/TeX/texbin" (getenv "PATH")))
(setq exec-path (append '("/Library/TeX/texbin") exec-path))
(add-to-list 'exec-path (expand-file-name "~/Library/Application\ Support/Code/User/globalStorage/matklad.rust-analyzer"))
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

(setq doom-theme 'doom-one)

(setq org-directory "~/org/")
(setq display-line-numbers-type 'relative)

(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-unicode-font (font-spec :family "Noto Serif CJK JP" :size 15)
      doom-big-font (font-spec :family "JetBrains Mono" :size 18)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 18)
      doom-serif-font (font-spec :family "JetBrains Mono" :weight 'light))

(after! org
  (setq org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))
  )

(when (require 'org-tree-slide nil t)
  (define-key org-tree-slide-mode-map (kbd "<f9>")
    'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<f10>")
    'org-tree-slide-move-next-tree)
  (define-key org-tree-slide-mode-map (kbd "<f11>")
    'org-tree-slide-content)
  )

(use-package! wakatime-mode
  :ensure t
  :when (file-exists-p "~/.wakatime.cfg")
  :init
  (global-wakatime-mode))

(use-package! lsp-mode
  :ensure t
  :init (yas-global-mode)
  :hook (rust-mode . lsp)
  :bind ("C-c h" . lsp-describe-thing-at-point)
  :custom (lsp-rust-server 'rust-analyzer))
(use-package! lsp-ui
  :ensure t)

(setq inferior-lisp-program "/usr/local/bin/sbcl")

(use-package! rust-mode
  :ensure t
  :custom rust-format-on-save t)
(use-package! cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

(provide 'config)
;;; config.el ends here
