;;; -*-emacs-lisp-*-
;;;
;;; $Id$	

(setq nntp-authinfo-user "merlinus")
(setq nntp-authinfo-password "zxc786ig")

;; primary methods
(setq
 gnus-select-method '(nnml "private")
 gnus-secondary-select-methods nil
 )

(setq mail-sources
      '((file)
	(directory :path "/home/edh/Mail/mail-incoming/")))

;; mailcrypt
;(autoload 'mc-install-write-mode "mailcrypt" nil t)
;(autoload 'mc-install-read-mode "mailcrypt" nil t)
;(add-hook 'mail-mode-hook 'mc-install-write-mode)
;(setq gnus-use-mailcrypt t)

;; misc 
(add-hook 'message-mode-hook 'font-lock-mode)
(setq message-max-buffers 5)		; default 10, nil => keep all

;; bbdb -- Insidious Big Brother Database; for use with VM and GNUS
(require 'bbdb)
(bbdb-initialize 'gnus 'message 'w3)
(bbdb-insinuate-gnus)
(bbdb-insinuate-message)
(setq gnus-use-bbdb t)
(setq gnus-optional-headers 'bbdb/gnus-lines-and-from)

(define-key message-mode-map "\M-\C-i" 'bbdb-complete-name)

;; initialize
;(add-hook 'gnus-load-hook 'turn-off-filladapt-mode)
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; customize article buffer
;(add-hook 'gnus-article-display-hook 'gnus-article-emphasize)
;(add-hook 'gnus-article-display-hook 'gnus-article-highlight)
;(add-hook 'gnus-article-display-hook 'gnus-article-treat-overstrike)
;(add-hook 'gnus-article-display-hook 'gnus-article-add-buttons)
(add-hook 'gnus-article-mode-hook
	  '(lambda ()
	     (setq truncate-partial-width-windows nil)
	     (setq truncate-lines nil)))

;; XEmacs special stuff (smileys, faces)
(when (string-match "XEmacs" emacs-version)
  (add-hook 'gnus-article-display-hook 'gnus-article-display-x-face t)
  (add-hook 'gnus-article-display-hook 'gnus-smiley-display t)
  (setq smiley-regexp-alist 'smiley-nosey-regexp-alist) ; less aggressive
  )

(setq gnus-visible-headers "^From:\\|^Newsgroups:\\|^Subject:\\|^Date:\\|^Followup-To:\\|^Reply-To:\\|^Organization:\\|^Summary:\\|^Keywords:\\|^To:\\|^Cc:\\|^Approved:\\|^Posted-To:\\|^Mail-Copies-To:\\|^Apparently-To:\\|^Gnus-Warning:\\|^NNTP-Posting-Host:\\|^X-Mailer:\\|^X-Newsreader:\\|^X-Spook:\\|^X-NSA-Fodder:\\|^Path:\\|^X-Geek\\|^X-URL\\|^Resent-From:\\|X-Originating-IP:\\|^User-Agent:")
(setq gnus-sorted-header-list '("^Path:" "^Newsgroups:" "^From:" "^Subject:" "^To:" "^C[Cc]:" "^Date:" "^Keywords:" "^Summary:" "^Organization:")) ; "^[^X]\-"))

(setq message-default-headers		; add custom mail headers b4 editing
      (concat
;      "Reply-To: " user-mail-address "\n"
       "Organization: The Weylani-Yutano Corporation" "\n"
       "X-URL: <a href=\"http://www.crystalcave.net/~edh/\">The Crystal Cave</a>" "\n"
       "X-sPoOk: " "\n"
       )
      )

(load "spook")
(add-hook 'message-setup-hook
	  '(lambda ()
	     (bbdb-define-all-aliases)
	     (message-position-on-field "X-Spook")
	     (insert (mapconcat
		      '(lambda (dummy) ; fake a for loop
			 (cookie spook-phrases-file
				 "hi" "mom"))
		      '(1 2 3 4 5 6)
		      " "))))

;; Thu Apr 30 00:54:18 EDT 1998
;(defun my-signature ()
;  (cond ((and (boundp 'gnus-newsgroup-name)
;	      (string-match "^nnml" gnus-newsgroup-name))
;	 (progn (setq message-signature-file ".signature")
;		t))
;	(t
;	 (progn (setq message-signature-file ".signature2")
;		t))))
;(setq message-signature 'my-signature)
(setq message-signature nil)

;; Sat Aug 19 22:47:20 CDT 1995
;(defun message-header-empty (header)
;  "Returns true if the given mail header is empty."
;  (message-position-on-field header)	; puts point at end of header
;  (beginning-of-line)
;  (forward-char (+ (length header) 2))
;  (cond ((eolp) t)))

;(defun message-insert-citation-line ()
;  "Function that inserts a simple citation line."
;  (when message-reply-headers
;    (insert "Eric says: \"I'm going to Koh Phangan and taking " (mail-header-from message-reply-headers) "\"\n\n")))

(setq
;gnus-audio-au-player "/usr/bin/play"
;gnus-audio-wav-player "/usr/bin/play"
 gnus-check-new-newsgroups nil
;gnus-default-article-saver 'gnus-summary-save-in-mail
 gnus-expert-user t			; *never* ask for confirmation
;gnus-read-active-file nil
;gnus-save-killed-list nil
;gnus-single-article-buffer nil		; don't use the same article buffer
 gnus-subscribe-hierarchical-interactive t
 gnus-subscribe-newsgroup-method 'gnus-subscribe-hierarchically
 gnus-summary-goto-unread nil		; don't skip to next unread
;gnus-thread-ignore-subject t		; don't start a new thread if changes
 )


;; mime settings
(setq message-send-mail-partially-limit nil) ; Outlook no grok multi-part msgs
(setq gnus-ignored-mime-types
      '("text/x-vcard")
      )
(defun my-save-all-jpeg-parts (handle)
  (when (equal (car (mm-handle-type handle)) "image/jpeg")
    (with-temp-buffer
      (insert (mm-get-part handle))
      (write-region (point-min) (point-max)
		    (read-file-name "Save jpeg to: ")))))
;(setq gnus-article-mime-part-function 'my-save-all-jpeg-parts)

(setq gnus-message-archive-group	; archive outgoing mail/news
      '((if (message-news-p)
            "news-outgoing"
          (concat "mail-outgoing."
		  (format-time-string "%Y.")
		  (format-time-string "%m")))))

;; group highlighting
;(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)
;(add-hook 'gnus-group-catchup-group-hook 'gnus-group-set-timestamp)
;(gnus-demon-add-scan-timestamps)

;; for mail reading
(setq
 nnmail-split-methods
 '(("mail.mpm" "^To:.*mpls@pm.org")
   ("mail.fetchmail" "^\\(To\\|Cc\\):.*fetchmail-friends@")
   ("mail.mandrake-expert" "^\\(To\\|Cc\\):.*expert@")
   ("mail.mandrake-newbie" "^\\(To\\|Cc\\):.*newbie@")
   ("mail.ip" "^\\(To\\|Cc\\):.*ip-sub-1@")
   ("mail.gnus" "^\\(To\\|Cc\\):.*ding@")
   ("mail.bugtraq" "^\\(To\\|Cc\\):.*bugtraq@")
   ("mail.bugtraq" "^Resent-From:.*aleph1@")
   ("mail.other" "")
   )
 )
(setq
 nnmail-use-long-file-names nil	; break groups up into subdirs
 nnmail-procmail-directory "~/Mail/mail-incoming" ; procmail folders
 nnmail-use-procmail t
 nnmail-resplit-incoming t		; resplit procmail filtered folders
 )

;; customize forwarded subjects
(defun message-make-forward-subject ()
  "Return a Subject header suitable for the message in the current buffer."
  (concat (or (message-fetch-field "Subject") "") " [fwd]"))
; (concat "[" (or (message-fetch-field 
;		   (if (message-news-p) "newsgroups" "from"))
;		  "(nowhere)")
;	  "] " (or (message-fetch-field "Subject") "")))

;;
;; Personalizing BBDB
;;

(add-hook 'bbdb-change-hook 'bbdb-timestamp-hook) ; last modified date field
;(add-hook 'bbdb-create-hook 'bbdb-creation-date-hook) ; creation date field
(add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook) ; see -auto-notes-alist

(add-hook 'bbdb-load-hook 
	  (lambda ()
	    (define-key minibuffer-local-map "\M-\t" 'bbdb-complete-name)
	    ))

(setq
;bbdb-canonicalize-redundant-nets-p t	; filter out redundant addresses
 bbdb-default-area-code 612
 bbdb-offer-save 'auto			; just go ahead and save .bbdb
 bbdb-use-pop-up nil
 )

;; BBDB specific to certain packages
;(setq bbdb/gnus-header-prefer-real-names t
;      bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook) ; see -ignore-
;(autoload 'bbdb/gnus-lines-and-from "bbdb-gnus")

;(setq bbdb-print-elide '(tex-name aka mail-alias face last-subj creation-date timestamp newsgroups notes url))

;(setq bbdb-ignore-some-messages-alist
;      '(("From" . "mailer.daemon\\|root\\|news\\|daemon\\|usenet\\|uucp\\|ssa\\|room33\\|postmaster\\|adm\\|listserv\\|vacation")
;	("Newsgroups" . ".*")
;	("To" . "mailing-list-1\\|mailing-list-2") ; sample
;	("CC" . "mailing-list-1\\|mailing-list-2"))) ; sample

(put 'newsgroups 'field-separator ", ")
(put 'notes 'field-separator ", ")
;;(define-key bbdb-mode-map "c" 'bbdb-create)
