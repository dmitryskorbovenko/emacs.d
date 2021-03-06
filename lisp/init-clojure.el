(defun change-lamda-chars (mode)
  (font-lock-add-keywords
   mode
   `(("(\\(fn\\)[\[[:space:]]"  ; anon funcs 1
      (0 (progn (compose-region (match-beginning 1)
                                (match-end 1) "λ")
                nil)))
     ("\\(#\\)("                ; anon funcs 2
      (0 (progn (compose-region (match-beginning 1)
                                (match-end 1) "ƒ")
                nil)))
     ("\\(#\\){"                 ; sets
      (0 (progn (compose-region (match-beginning 1)
                                (match-end 1) "∈")
                nil))))))

(use-package clojure-mode
  :ensure t
  :mode  (("\\.clj" . clojure-mode)
          ("\\.cljs" . clojurescript-mode))
  :config

  (change-lamda-chars 'clojure-mode)
  (change-lamda-chars 'clojurescript-mode)

  (add-hook 'clojure-mode-hook #'eldoc-mode)
  (add-hook 'clojurescript-mode-hook #'eldoc-mode))


(defun manu/clj-format-before-save-hook ()
  (when (eq major-mode 'clojure-mode)
    (cider-format-buffer)))

(use-package cider
  :ensure t
  :after clojure-mode
  :config
  (setq org-babel-clojure-backend 'cider)
  (add-hook 'cider-mode-hook #'smartparens-mode)
  (add-hook 'cider-mode-hook #'eldoc-mode)

  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)

  (change-lamda-chars 'cider-mode)

  ;; Config CIDER figwheel
  ;; (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

  ;; Shortcut keys config
  (define-key clojure-mode-map (kbd "C-c r") #'cider-jack-in)
  (define-key clojure-mode-map (kbd "C-c s") #'cider-jack-in-clojurescript)

  ;; Format buffer
  (add-hook 'before-save-hook #'manu/clj-format-before-save-hook)


  (setq nrepl-hide-special-buffers t
        cider-repl-pop-to-buffer-on-connect nil
        cider-popup-stacktraces nil
        cider-repl-popup-stacktraces nil
        cider-show-error-buffer nil))

(use-package clj-refactor
  :ensure t
  :diminish clj-refactor-mode
  :after clojure-mode
  :config
  (yas-minor-mode 1)
  (clj-refactor-mode 1))

(use-package rainbow-delimiters
  :ensure t
  :after clojure-mode
  :diminish rainbow-delimiters-mode
  :config
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'clojurescript-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'cider-mode-hook #'rainbow-delimiters-mode))


(use-package flycheck-clojure
  :ensure t
  :after (clojure-mode flycheck)
  :config (flycheck-clojure-setup))

;; (use-package flycheck-pos-tip
;;   :ensure t
;;   :after flycheck
;;   :config
;;   (when (eq major-mode 'clojure-mode)
;;     (setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))



;; INDENTATION ALWAYS 2 SPACES
;; (setq clojure-defun-style-default-indent t)


(provide 'init-clojure)
