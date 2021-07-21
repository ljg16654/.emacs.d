(require 'arche-package)
(use-package pyim
  :config
  ;; quanpin
  (setq pyim-default-scheme 'quanpin)
  ;; (pyim-isearch-mode 1)
  (setq pyim-page-tooltip 'posframe)
  (setq pyim-page-length 5))

(use-package pyim-basedict
  :config (pyim-basedict-enable))

(defun arche/toggle-input-method (&optional im)
  (if current-input-method
      (set-input-method nil)
    (set-input-method im)))

;; TODO: resolve conflict with meow.el
;; activation in normal-mode overrides (kbd "i")
(defun arche/toggle-cn-im ()
  (interactive)
  (arche/toggle-input-method "pyim"))

(defun arche/toggle-TeX-im ()
  (interactive)
  (arche/toggle-input-method "TeX")) 

(provide 'arche-im)
