;;;
;;; eric's emacs start-up				18 august, 1991
;;; edh@crystalcave.net

;;; history
;;;  o heavily revamped summer 1992
;;;  o updated for Emacs 19 summer 1993
;;;  o cleaned and split up to use with both FSFEmacs and XEmacs september 1995
;;;  o started fresh summer 1996, XEmacs only

;;; $Id$	

;; debugging
;(setq debug-on-error t)

;(setq default-fill-column 75)		; allows room for prepending "> "
(setq default-major-mode 'text-mode)
(setq indent-tabs-mode nil)		; insert spaces rather than C-i
(setq lpr-command "enscript")
(setq lpr-switches '("-G -CEric"))
(setq track-eol t)                      ; follow end-of-line with C-n, C-p
(setq truncate-partial-width-windows t) ; no line wrapping
(setq frame-background-mode 'light)

;;; backups
(setq kept-new-versions 1)              ; default 2
(setq kept-old-versions 1)              ; default 2
(setq delete-old-versions t)
(setq version-control t)

(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-cw" 'what-line)
(global-set-key "\C-xs" 'save-buffer)	; as opposed to save-some-buffers
(global-set-key "\C-cr" 'replace-string)
(global-set-key "\C-cb" 'insert-buffer)	; analog to insert-file

;; for Sun keypads and vt100 in cursor keys mode
(global-set-key "\eOA" 'previous-line)  ; up arrow (R8)
(global-set-key "\eOB" 'next-line)      ; down arrow (R14)
(global-set-key "\eOC" 'forward-char)   ; forward arrow (R12)
(global-set-key "\eOD" 'backward-char)  ; backward arrow (R10)

(global-unset-key "\e[")                ; allow (e.g. Sun) keypad to be bound

(global-set-key "\e[214z" 'beginning-of-buffer) ; Home key (R7)
(global-set-key "\e[216z" 'scroll-down) ; PgUp key (R9)
(global-set-key "\e[218z" 'recenter)    ; 5 key (R11)
(global-set-key "\e[220z" 'end-of-buffer) ; End key (R13)
(global-set-key "\e[222z" 'scroll-up)   ; PgDn key (R15)

;; Logitech scrolling middle mouse-button
(global-set-key 'button4 'previous-line)
(global-set-key 'button5 'next-line)

(global-set-key "\e[A" 'previous-line)  ; up arrow
(global-set-key "\e[B" 'next-line)      ; down arrow
(global-set-key "\e[C" 'forward-char)   ; forward arrow
(global-set-key "\e[D" 'backward-char)  ; backward arrow

;; put help under C-h and make backspace another delete key
(global-set-key [(control h)] 'help-command)
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key [backspace] 'delete-backward-char)

;;; automatic indentation

;; I hate having to type C-j to get automatic indentation, so swap with C-m.
(define-key emacs-lisp-mode-map "\C-m" 'reindent-then-newline-and-indent)
(define-key emacs-lisp-mode-map "\C-j" 'newline)
(define-key lisp-mode-map "\C-m" 'reindent-then-newline-and-indent)
(define-key lisp-mode-map "\C-j" 'newline)
(define-key lisp-interaction-mode-map "\C-m" 'eval-print-last-sexp)
(define-key lisp-interaction-mode-map "\C-j" 'newline)

;; these need to be wrapped in add-hooks as they are not loaded automatically
;(add-hook 'html-mode-hook
;	  (lambda ()
;	    (define-key html-mode-map "\C-m" 'reindent-then-newline-and-indent)
;	    (define-key html-mode-map "\C-j" 'newline)
;	    ))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (define-key c-mode-map "\C-m" 'reindent-then-newline-and-indent)
	    (define-key c-mode-map "\C-j" 'newline)
	    (c-set-offset 'case-label 2))) ; default is 0

(add-hook 'cperl-mode-hook
	  '(lambda ()
	     (define-key cperl-mode-map "\C-m"
	       'reindent-then-newline-and-indent)
	     (define-key cperl-mode-map "\C-j" 'newline)))

;; use color even in tty's
(if (eq 'tty (device-type))
    (set-device-class nil 'color))

;; gnuserv for gnuattach
(gnuserv-start)

;; version control
(require 'vc-hooks)

;; time and load average in the modeline
(display-time)

;; save minibuffer history
(savehist-load)

;; mailcrypt
(autoload 'mc-install-write-mode "mailcrypt" nil t)
(autoload 'mc-install-read-mode "mailcrypt" nil t)
(add-hook 'mail-mode-hook 'mc-install-write-mode)

;; crypto
(setq crypt-encryption-type 'pgp	; default encryption mechanism
;     crypt-never-ever-decrypt t	; don't assume that "binary" files are
					; encrypted and require a password.
      crypt-confirm-password t		; make sure new passwords are correct
      )
(require 'crypt)

;; filladapt
(require 'filladapt)
(add-hook 'text-mode-hook 'turn-on-filladapt-mode)

;; tools for mime
(load "mime-setup")

;; webster
;(autoload 'webster "webster" "look up a word in Webster's 7th edition" t)
;(setq webster-host "128.101.169.103")

;; Dired
(setq dired-listing-switches "-Flat")   ; sort on time
(add-hook 'dired-load-hook
          '(lambda ()
             (setq case-fold-search t)	; case insensitive search
             (define-key dired-mode-map " " 'scroll-up)
             (define-key dired-mode-map "b" 'scroll-down)
             (define-key dired-mode-map "c" 'dired-do-copy)))

;; font-lock
(add-hook 'dired-mode-hook
	  '(lambda () 
;	     (setq font-lock-keywords dired-font-lock-keywords)
	     (font-lock-mode t)))

;; efs
;(require 'efs)				; replaces ange-ftp
(setq efs-use-passive-mode t)

;; ZenIRC
(require 'zenirc)
(load "/home/edh/.zenirc")

;;;
;;; defun's
;;;

;; do % parenthesis matching in emacs, as in vi
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis else insert %."
  (interactive "p")
  (cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
        ((looking-at "[])}]") (forward-char) (backward-sexp 1))
        (t (self-insert-command (or arg)))))
(global-set-key "%" 'match-paren)

;; date function (useful for logging times in job notes, etc ...)
(defun current-date-and-time ()
  "Insert the current date and time (as given by UNIX date) at dot."
  (interactive)
  (call-process "date" nil t nil))
(global-set-key "\C-ct" 'current-date-and-time)

(defun current-date-euro ()
  "Insert the current date at dot, in european format: DD MMM, YYYY."
  (interactive)
  (call-process "date" nil t nil "+%d %b %Y"))
(global-set-key "\C-ce" 'current-date-euro)

(defun insert-yow ()
       "Insert a yow at dot"
       (interactive)
       (call-process "yow" nil t nil))
(global-set-key "\C-cy" 'insert-yow)

;; insert current Emacs version string
(defun insert-emacs-version ()
  (interactive)
  (insert (emacs-version)))
(global-set-key "\C-cv" 'insert-emacs-version) ; (insert (emacs-version))

;; start an X frame
;; Thu Aug  1 14:22:25 CDT 1996
(defun my-start-x-frame ()
  "My short cut to start up an X frame from within a tty XEmacs."
  (interactive)
  (setenv "DISPLAY" "ginseng.boston.deshaw.com:0") ; needed for netscape  :(
  (make-frame-on-device 'x (getenv "DISPLAY"))
  )
(global-set-key "\C-c\C-x" 'my-start-x-frame)

;; queue mail for outgoing via cron
;; Wed Apr 16 16:55:40 EDT 1997
(defun my-mail-outgoing ()
  "My function for saving a message in a queue to be picked up via cron."
  
  )

;; Change the pointer used when the mouse is over a modeline
(set-glyph-image modeline-pointer-glyph "leftbutton")

;; Change the cursor used during garbage collection.
(if (featurep 'xpm)
    (set-glyph-image gc-pointer-glyph
		     (expand-file-name "recycle.xpm" data-directory)))

;; for `` '' quoting in text-mode
(defvar tex-open-quote "``"
    "*String inserted by typing \\[tex-insert-quote] to open a quotation.")

(defvar tex-close-quote "''"
    "*String inserted by typing \\[tex-insert-quote] to close a quotation.")

(defun TeX-insert-quote (arg)
  "Insert the appropriate quote marks for TeX.
Inserts the value of tex-open-quote (normally ``) or tex-close-quote
(normally '') depending on the context.  With prefix argument, always
inserts \" characters."
(interactive "*P")
(if arg
    (self-insert-command (prefix-numeric-value arg))
  (insert
   (cond ((or (bobp)
              (save-excursion
                (forward-char -1)
                (looking-at "\\s(\\|\\s \\|\\s>")))
          tex-open-quote)
         ((= (preceding-char) ?\\)
          ?\")
         (t
          tex-close-quote)))))

(setq TeX-mode-hook
      '(lambda ()
	 (local-set-key "\"" 'TeX-insert-quote) ; use double single-quotes
	 ))

(setq text-mode-hook
      '(lambda ()
         (setq indent-tabs-mode t)      ; use real tabs in text mode
         (auto-fill-mode 1)		; auto-wrap as you type
         ))

;; for auctex
(require 'tex-site)			; should be in site-init.el?

(custom-set-variables
 '(require-final-newline (quote ask))
 '(display-time-24hr-format t)
 '(browse-url-browser-function (quote browse-url-netscape))
 '(ps-print-color-p t)
 '(toolbar-visible-p nil)
 '(display-time-day-and-date t)
 '(user-mail-address "edh@visi.com" t)
 '(query-user-mail-address nil)
 '(font-lock-mode t nil (font-lock)))
(custom-set-faces
 '(default ((t (:size "18pt"))) t))

;; Options Menu Settings
;; =====================
(cond
 ((and (string-match "XEmacs" emacs-version)
       (boundp 'emacs-major-version)
       (or (and
            (= emacs-major-version 19)
            (>= emacs-minor-version 14))
           (= emacs-major-version 20))
       (fboundp 'load-options-file))
  (load-options-file "/home/edh/.xemacs-options")))
;; ============================
;; End of Options Menu Settings

;;; Local Variables:
;;; eval: (defun byte-compile-this-file () (write-region (point-min) (point-max) buffer-file-name nil 't) (byte-compile-file buffer-file-name t) t)
;;; write-file-hooks: (byte-compile-this-file)
;;; End:
