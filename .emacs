;; -*- mode: emacs-lisp -*-
(package-initialize)

(require 'xcscope)
(require 'cc-mode)

;; MELPA packages

(require 'package) 
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;; set style
;;(setq-default c-basic-offset 2 c-default-style "linux")`(setq-default tab-width 8 indent-tabs-mode t)
;;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;; auto repair brackets
;;(require 'autopair)
;;(autopair-global-mode 1)
;;(setq autopair-autowrap t)

;;; yasnippet
;;; should be loaded before auto complete so that they can work together
;;(require 'yasnippet)
;;(yas-global-mode 1)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(add-to-list 'load-path "~/.emacs.d/elpa")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

(require 'ac-clang)
(define-key c++-mode-map (kbd "C-S-<return>") 'ac-complete-clang)
;; replace C-S-<return> with a key binding that you want

; change moving between windows to Shift+{left,up,down,right}
(windmove-default-keybindings)
(setq windmove-wrap-around t)

; Save space
(menu-bar-mode nil)

; Handle .gz files
(auto-compression-mode t)

; Provide templates for new files
(auto-insert-mode t)

;display column number
(column-number-mode 1)

; Allow completions like em-s-region to complete to emacspeak-speak-region
;;(partial-completion-mode)

;; This somehow produced a failure on excelior
;;(add-hook 'after-init-hook 'server-start)
;;(add-hook 'server-done-hook
;;	  (lambda ()
;;	    (shell-command "screen -r -X select `cat ~/tmp/emacsclient-caller`");;))

;;(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;;(unless (featurep 'emacspeak)
;;  (add-hook 'emacs-lisp-mode-hook 'eldoc-mode))

; Update string in the first 8 lines looking like Timestamp: <> or " "
;;(add-hook 'write-file-hooks 'time-stamp)

;;; Diary
;(setq diary-file "~/emacs/diary")
;(add-hook 'diary-hook 'appt-make-list)
;(diary 0)

;;; Eshell
;;(eval-after-load "em-term"
 ;; '(add-to-list 'eshell-visual-commands "zsh"))

;;; Gnus
;;(setq gnus-init-file "~/emacs/.gnus.el")

;;; Abbrevs
; Use C-xaig to correct common typos
(setq abbrev-file-name "~/emacs/abbrev_defs")
(if (file-exists-p abbrev-file-name)
    (quietly-read-abbrev-file))
(set-default 'abbrev-mode t)

;; Misc options I just prefer everytime
(setq cperl-indent-level 2
      custom-buffer-indent 2
      gc-cons-threshold (* 1024 1024)
      european-calendar-style t
      mail-user-agent 'message-user-agent
      message-generate-headers-first t
      w3-display-frames 'ask
      widget-choice-toggle t
      widget-menu-minibuffer-flag t
      url-privacy-level '(os agent)
      vc-cvs-diff-switches "-u")


(put 'narrow-to-region 'disabled nil)

;;; Crypt++

(require 'crypt++ nil t)
(setq crypt-encryption-type 'mcrypt)

;;; Internet Time

;(add-to-list 'load-path (expand-file-name "~/emacs/lisp/"))
;(require 'itime)
;(setq display-time-string-forms
;      '(24-hours ":" minutes " "
;		 (itime-string 24-hours minutes seconds)
;		 (if mail
;		     " Mail"
;		   ""))
;       display-time-interval 30)
;(display-time-mode 1)


;;; Load local configuration
;;(condition-case data
;;    (let ((default-directory "~/emacs/"))
;;      (load-file "./local"))
;;  (file-error 'notfound))

;;; Load Customize

;;(if (file-exists-p
;;     (setq custom-file;
;;	   (concat "~/emacs/custom-" 
;;		   (int-to-string emacs-major-version))))
;;    (load-file custom-file))

;;; Semantic

;(unless (featurep 'emacspeak)
;  (global-semantic-auto-parse-mode 1)
;  (unless (featurep 'emacspeak)
;    (setq semantic-auto-parse-no-working-message t))
;  (add-hook 'semantic-init-hooks 'senator-minor-mode))


;; Emacs wiki

;;(require 'emacs-wiki)
;;(add-to-list 'emacs-wiki-interwiki-names '("Bug" . "http://bugs.debian.org/"))
;;(add-to-list 'emacs-wiki-interwiki-names '("Package" . "http://packages.debian.org/"))
;;(setq
;; emacs-wiki-projects
;; '(
;;   ("PrivateNotes"
;;    (emacs-wiki-directories "~/doc/private"))
;;   ("DebianWiki"
;;    (emacs-wiki-directories "~/debian/notes")
;    (emacs-wiki-publishing-directory . "/[su/mlang@gluck.debian.org]~/public_html/")
;;    (emacs-wiki-publishing-directory . "~/debian/public_html")
;;    )))

(when (featurep 'emacspeak)
  (defun viavoice-set-language (lang)
    (cond
     ((eq lang 'german)
      (dtk-interp-queue "`l4 Deutsch")
    (dtk-interp-speak))
     ((eq lang 'english)
      (dtk-interp-queue "`l1 English")
      (dtk-interp-speak))
     (t (error "Unknown language"))))
  (defun emacspeak-set-language-to-german ()
    (interactive)
    (viavoice-set-language 'german))
  (defun emacspeak-set-language-to-english ()
    (interactive)
    (viavoice-set-language 'english))
  (global-set-key (kbd "C-c e") 'emacspeak-set-language-to-english)
  (global-set-key (kbd "C-c d") 'emacspeak-set-language-to-german))

(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c g") 'grep)
;(define-prefix-command 'f8-map nil "f7=grep, f8=compile")
;(define-key f8-map [f8] 'compile)
;(define-key f8-map [f7] 'grep)
;(global-set-key [f8] 'f8-map)
;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(load-home-init-file t t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))

;;(defun c-lineup-arglist-tabs-only (ignored) 
;;   "Line up argument lists by tabs, not spaces" 
;;   (let* ((anchor (c-langelem-pos c-syntactic-element)) 
;;         (column (c-langelem-2nd-pos c-syntactic-element)) 
;;         (offset (- (1+ column) anchor)) 
;;         (steps (floor offset c-basic-offset))) 
;;     (* (max steps 1) 
;;        c-basic-offset))) 

;; Add kernel style 
;;(c-add-style 
;;  "linux-tabs-only" 
;;  '("linux" (c-offsets-alist 
;;            (arglist-cont-nonempty 
;;             c-lineup-gcc-asm-reg 
;;             c-lineup-arglist-tabs-only)))) 
;;(custom-set-variables 
;;  '(c-default-style "linux-tabs-only") 
;;) 

'(c-max-one-liner-length 80)

'(fill-column 80)
'(c-ignore-auto-fill (quote (string cpp)))

; cedet semantic
;;(semantic-mode 1)

;;(require 'semantic/ia)
;;(require 'semantic/bovine/gcc)

;;(defun my-semantic-hook ()
;;  (imenu-add-to-menubar "TAGS"))
;;(add-hook 'semantic-init-hooks 'my-semantic-hook)

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 120))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 200)
                             (frame-char-height)))))))

(set-frame-size-according-to-resolution)

;;;;;;;;;;
;;; c-mode
(setq c-default-style '((c-mode . "cc-mode")
			(java-mode . "java")
			(awk-mode . "awk")
			(other . "cc-mode")))

(setq-default indent-tabs-mode nil)
;;(setq-default c-default-style "cc-mode")

;;defun my-c-mode-hook ()
;;  (setq c-basic-offset 4
;;       c-indent-level 4
;;       c-default-style "cc-mode"))
;;(add-hook 'c-mode-common-hook 'my-c-mode-hook)

(c-add-style "my-style" 
	     '("cc-mode"
	       (indent-tabs-mode t)        ; use spaces rather than tabs
	       (c-basic-offset . 2)         ; indent by 2 spaces
	       (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
                               (brace-list-open . 0)
                               (statement-case-open . +)))))

(defun my-c++-mode-hook ()
  (c-set-style "my-style")        ; use my-style defined above
  (auto-fill-mode)
  (c-toggle-auto-hungry-state 1)
  (c-toggle-auto-state 1)
  (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
)

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(setq-default show-trailing-whitespace t)

(load-file "/home/owasserm/emacs-for-python/epy-init.el")
(add-to-list 'load-path "/home/owasserm/emacs-for-python/") ;; tell where to load the various files
(require 'epy-setup)      ;; It will setup other loads, it is required!
(require 'epy-python)     ;; If you want the python facilities [optional]
(require 'epy-completion) ;; If you want the autocompletion settings [optional]
(require 'epy-editing)    ;; For configurations related to editing [optional]
(require 'epy-nose)       ;; For nose integration

(add-hook 'python-mode-hook (function cscope:hook))
