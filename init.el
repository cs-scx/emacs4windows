(load-theme 'manoj-dark t)

;; 启用行号显示
(global-display-line-numbers-mode t)
;; 启用相对行号显示
(setq display-line-numbers 'relative)

(set-face-attribute 'default nil :font "Consolas-14")

(require 'package)

;; 设置清华源
(setq package-archives '(
                         ("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                                                                                   ))

;; 初始化包管理器
(package-initialize)

;; 如果没有 use-package，请先安装 use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; 启用 use-package
(eval-when-compile
  (require 'use-package))

;; 使用 company-mode 自动补全
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

;; 使用 ivy 进行增强的 minibuffer 补全
(use-package ivy
  :ensure t
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; 使用 counsel 提供更多 Ivy 增强功能
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (counsel-mode 1))

;; 使用 swiper 进行增强的搜索
(use-package swiper
  :ensure t
  :bind (("C-s" . swiper))
  :config
  (setq swiper-action-recenter t)
  (setq swiper-include-line-number-in-search t))

;; 安装并启用 evil-mode
(use-package evil
  :ensure t
  :init
  ;;(setq evil-want-integration t) ;; 需要此行才能正常工作
  ;;(setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;; 启用 recentf 模式
(require 'recentf)
(recentf-mode 1)

;; 设置 recentf 保存的文件数量
(setq recentf-max-saved-items 100)

;; 设置 recentf 保存的文件路径
(setq recentf-save-file (expand-file-name "recentf" "~/.emacs.d"))

;; 自动保存 recentf 列表
(run-at-time nil (* 5 60) 'recentf-save-list)

;; 绑定快捷键以打开 recentf 文件列表
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
