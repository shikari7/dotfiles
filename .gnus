;;; -*-emacs-lisp-*-
;;;
;;; $Id$	

;; primary methods
(setq
 gnus-select-method '(nntp "news.mr.net")
 gnus-secondary-select-methods '((nnml "private") (nntp "localhost" (nntp-port-number 1701)))
 )

; what is this?
;(setq gnus-extra-headers nil)

;; use iso8859-1 fonts
;(if (string-equal (frame-type) 'x)
(cond ((console-on-window-system-p)
       (standard-display-european t))
      (t (eq (console-type) 'tty))
      (require 'iso-ascii))

;; disable Sender: field
;(setq message-syntax-checks '((sender . disabled)))

;; mailcrypt
(setq gnus-use-mailcrypt t)
(add-hook 'gnus-summary-mode-hook 'mc-install-read-mode)
(add-hook 'news-reply-mode-hook 'mc-install-write-mode)
(add-hook 'message-mode-hook 'font-lock-mode)

;; bbdb -- Insidious Big Brother Database; for use with VM and GNUS
(require 'bbdb)
(bbdb-initialize 'gnus 'message 'sc 'w3)
(bbdb-insinuate-gnus)
(bbdb-insinuate-message)
(setq gnus-use-bbdb t)
(setq gnus-optional-headers 'bbdb/gnus-lines-and-from)

(define-key gnus-article-mode-map "\C-h" 'gnus-article-prev-page)
(define-key gnus-summary-mode-map "\C-h" 'gnus-summary-prev-page)
(define-key message-mode-map "\M-\C-i" 'bbdb-complete-name)

;; initialize
(add-hook 'gnus-load-hook 'turn-off-filladapt-mode)
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; customize article buffer
(add-hook 'gnus-article-display-hook 'gnus-article-display-x-face t)
(add-hook 'gnus-article-display-hook 'gnus-article-emphasize)
(add-hook 'gnus-article-display-hook 'gnus-article-highlight)
(add-hook 'gnus-article-display-hook 'gnus-smiley-display t)
(add-hook 'gnus-article-display-hook 'gnus-article-treat-overstrike)
(add-hook 'gnus-article-display-hook 'gnus-article-add-buttons)
(add-hook 'gnus-article-mode-hook
	  '(lambda ()
	     (setq truncate-partial-width-windows nil)
	     (setq truncate-lines nil)))

(setq gnus-visible-headers "^From:\\|^Newsgroups:\\|^Subject:\\|^Date:\\|^Followup-To:\\|^Reply-To:\\|^Organization:\\|^Summary:\\|^Keywords:\\|^To:\\|^Cc:\\|^Approved:\\|^Posted-To:\\|^Mail-Copies-To:\\|^Apparently-To:\\|^Gnus-Warning:\\|^NNTP-Posting-Host:\\|^X-Mailer:\\|^X-Newsreader:\\|^X-Spook:\\|^X-NSA-Fodder:\\|^Path:\\|^X-Geek\\|^X-URL\\|^Resent-From:\\|X-Originating-IP:")
(setq gnus-sorted-header-list '("^Path:" "^Newsgroups:" "^From:" "^Subject:" "^To:" "^C[Cc]:" "^Date:" "Keywords:" "Summary:" "Organization:")) ; "^[^X]\-"))

(setq message-default-headers		; add customized mail headers
      (concat
;      "Reply-To: " user-mail-address "\n"
       "Organization: The Weylani-Yutano Corporation" "\n"
       "X-URL: <a href=\"http://www.crystalcave.net/~edh/\">The Crystal Cave</a>" "\n"
       "X-sPoOk: " "\n"
       ))

(load "spook")

;; Thu Apr 30 00:54:18 EDT 1998
(defun my-signature ()
  (cond ((and (boundp 'gnus-newsgroup-name)
	      (string-match "^nnml" gnus-newsgroup-name))
	 (progn (setq message-signature-file ".signature")
		t))
	(t
	 (progn (setq message-signature-file ".signature2")
		t))))
(setq message-signature 'my-signature)

;; Sat Aug 19 22:47:20 CDT 1995
(defun message-header-empty (header)
  "Returns true if the given mail header is empty."
  (message-position-on-field header)	; puts point at end of header
  (beginning-of-line)
  (forward-char (+ (length header) 2))
  (cond ((eolp) t)))

(defun message-insert-citation-line ()
  "Function that inserts a simple citation line."
  (when message-reply-headers
    (insert (mail-header-from message-reply-headers) " says: \"I'm going to Ibiza and taking Eric.\"\n\n")))

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

(setq
 gnus-audio-au-player "/usr/bin/play"
 gnus-audio-wav-player "/usr/bin/play"
 gnus-auto-center-summary t
 gnus-auto-select-first nil
 gnus-check-new-newsgroups 'ask-server
 gnus-default-article-saver 'gnus-summary-save-in-mail
 gnus-expert-user t		; *never* ask for confirmation
;gnus-play-startup-jingle t
 gnus-read-active-file 'some
 gnus-save-killed-list nil
 gnus-single-article-buffer nil		; don't use the same article buffer
 gnus-subscribe-hierarchical-interactive t
 gnus-subscribe-newsgroup-method 'gnus-subscribe-hierarchically
 gnus-summary-goto-unread nil		; don't skip to next unread
 gnus-thread-ignore-subject t		; don't start a new thread if changes
 gnus-use-demon t			; do stuph when idle
 )

;; scoring
(setq gnus-decay-scores t)
(setq gnus-use-adaptive-scoring '(word))
(setq gnus-score-find-score-files-function
      '(gnus-score-find-bnews bbdb/gnus-score))

(setq gnus-message-archive-group	; archive outgoing mail/news
      '((if (message-news-p)
            "news-outgoing"
          (concat "mail-outgoing."
		  (format-time-string "%Y-%m" (current-time))))))

(setq
 gnus-use-trees t
 gnus-generate-tree-function 'gnus-generate-horizontal-tree
 gnus-tree-minimize-window nil
 )

(gnus-add-configuration
 '(article
   (horizontal 1.0
	       (vertical 0.42
			 (group 0.25)
			 (if gnus-use-trees '(tree 0.15))
			 (summary 1.0 point))
	       (vertical 1.0
;			 (picons 5)
			 (article 1.0)))))

(setq gnus-uu-user-view-rules 
      (list
       '("jpg$\\|gif$" "xv -perfect %s") 
       '("au$\\|snd$\\|wav$" "auplay -volume 100 %s")
       ))

;; group highlighting
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)
(add-hook 'gnus-group-catchup-group-hook 'gnus-group-set-timestamp)
(gnus-demon-add-scan-timestamps)

;; XEmacs special stuff (smileys, faces)
(when (string-match "XEmacs" emacs-version)
  (add-hook 'gnus-article-display-hook 'gnus-article-display-x-face t)
  (add-hook 'gnus-article-display-hook 'gnus-smiley-display t)
  (setq smiley-regexp-alist 'smiley-nosey-regexp-alist)) ; less aggressive

;; for mail reading
(setq nnmail-split-methods
      '(("mail.mtg-strategy-l" "^To:.*mtg-strategy-l@")
	("mail.mpm" "^To:.*mpm@")
	("mail.auctions" "^From:.*\\(auction-messages\\|aw-confirm\\)@")
	("mail.fetchmail" "^\\(To\\|Cc\\):.*fetchmail-friends@")
	("mail.gnus" "^\\(To\\|Cc\\):.*ding@")
	("mail.bugtraq" "^\\(To\\|Cc\\):.*bugtraq@")
	("mail.gto" "^\\(To\\|Cc\\):.*gto@")
	("mail.other" "")))
(setq nnmail-use-procmail t
      nnmail-procmail-directory "~/Mail/mail-incoming" ; location of procmail folders
      nnmail-use-long-file-names nil	; break groups up into subdirs
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

(setq bbdb-auto-notes-alist
      '(("To\\|Cc"
	 ("bugtraq" . "Bugtraq")
	 ("ding@" . "(ding) Gnus")
	 ("mtg-strategy-l@" . "MtG strategy")
	 ("tcsh" . "TCSH development"))
	("Subject" (".*" last-subj 0 t))
	("From" ("^\\([a-z]+\\)$" mail-alias 1))
	("Newsgroups" (".*" newsgroups 0 t))
	("X-Digest"
	 ("mtg-strategy-l" . "MtG strategy")
	 ("Yucks" . "yucks"))
	("X-Face" (".*" face 0 t))
	("X-Geek\\|X-Geek-3" (".*" geek 0 t))
	("X-URL\\|X-URI\\|X-www" (".*" url 0 t))
	("X-Organisation\\|X-Organization\\|Organisation\\|Organization" (".*" company 0 t))))

(setq bbdb-canonicalize-net-hook
      '(lambda (addr)
	 (cond ((string-match
		 "\\`\\([^@]+@\\).*\\.\\(cs\\.umn\\.edu\\)\\'" addr)
		(concat (substring addr (match-beginning 1) (match-end 1))
			(substring addr (match-beginning 2) (match-end 2))))
	       (t addr))))

(setq bbdb-always-add-addresses t
      bbdb-canonicalize-redundant-nets-p t ; filter out redundant addresses
      bbdb-default-area-code 612
      bbdb-electric-p t			; what does this do?
      bbdb-elided-display nil		; or (e.g.) '(address phone net notes)
;     bbdb-new-nets-always-primary t
      bbdb-offer-save 'auto		; just go ahead and save .bbdb
      bbdb-send-mail-style 'gnus-mail
;     bbdb-use-pop-up (> (screen-height) 24)
      bbdb-use-pop-up nil)

;; BBDB specific to certain packages
(setq bbdb/gnus-header-prefer-real-names t
;     bbdb/news-auto-create-p t		; way too many BBDB entries!!
      bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook) ; see -ignore-
(autoload 'bbdb/gnus-lines-and-from "bbdb-gnus")

(setq bbdb-print-elide '(tex-name aka mail-alias face last-subj creation-date timestamp newsgroups notes url))

(setq bbdb-ignore-some-messages-alist
      '(("From" . "mailer.daemon\\|root\\|news\\|daemon\\|usenet\\|uucp\\|ssa\\|room33\\|postmaster\\|adm\\|listserv\\|vacation")
	("Newsgroups" . ".*")
	("To" . "mailing-list-1\\|mailing-list-2") ; sample
	("CC" . "mailing-list-1\\|mailing-list-2"))) ; sample

(put 'newsgroups 'field-separator ", ")
(put 'notes 'field-separator ", ")
;;(define-key bbdb-mode-map "c" 'bbdb-create)
