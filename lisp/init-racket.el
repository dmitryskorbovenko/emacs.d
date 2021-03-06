(use-package racket-mode
  :ensure t
  :mode ("\\.rkt\\'" . racket-mode)
  :config
  ;;(setq racket-racket-program /usr/local/bin/racket)
  ;;(setq racket-raco-program /usr/local/bin/raco)
  (add-hook 'racket-mode-hook
            (lambda ()
              (define-key racket-mode-map (kbd "C-c r") 'racket-run)))

  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'racket-mode-hook #'rainbow-delimiters-mode)))

(provide 'init-racket)
