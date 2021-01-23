;;; package --- This is for the configuration
;;; Commentary:
;;; Code:

(setq user-full-name "Kadoi Takemaru"
      user-mail-address "diohabara@gmail.com")

(setenv "PATH" (concat "/Library/TeX/texbin" (getenv "PATH")))
(setq exec-path (append '("/Library/TeX/texbin") exec-path))

(setq doom-theme 'doom-one)

(setq org-directory "~/org/")
(setq display-line-numbers-type 'relative)

(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-big-font (font-spec :family "JetBrains Mono" :size 18)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 18)
      doom-serif-font (font-spec :family "JetBrains Mono" :weight 'light))

(after! org
  (setq org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))
  )

(use-package! wakatime-mode
  :ensure t
  :when (file-exists-p "~/.wakatime.cfg")
  :init
  (global-wakatime-mode))

(setq inferior-lisp-program "/usr/local/bin/sbcl")

(provide 'config)
;;; config.el ends here
