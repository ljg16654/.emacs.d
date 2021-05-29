;;* calendar
(setq calendar-longitude 121.5
      calendar-latitude 31.2)
;;* diary
(setq diary-file (file-truename (concat user-emacs-directory "diary")))

(defun arche-toggle-diary ()
  (interactive)
  (let
      ((bufn "*Fancy Diary Entries*"))
      (if (get-buffer bufn)
	  (kill-buffer bufn)
	(diary))))

(global-set-key (kbd "s-d") #'arche-toggle-diary)

;;* appointment
(setq
 ;; disable audible reminder
 appt-audible nil
 ;; In modeline, display number of minutes left to the appointment
 appt-display-mode-line t
 appt-message-warning-time 60
 ;; appt-warning-time-regexp
 )
(appt-activate t)

(defun my-refresh-canvas-ics ()
  (interactive)
  (let
      ((canvas-calendar-feed-url "https://www.umjicanvas.com/feeds/calendars/user_ZNPM8DdwWnHRg6gfFRMtg9r05mmgTuessZDEmjns.ics")
       (icalendar-fn "~/canvassync/ics_feed/canvas_export.ics"))
    (progn
      (url-copy-file
       canvas-calendar-feed-url
       icalendar-fn)
      (icalendar-import-file
       icalendar-fn
       "~/canvassync/ics_feed/canvas_diary"))))

(add-hook 'diary-list-entries-hook 'diary-include-other-diary-files)
(add-hook 'diary-mark-entries-hook 'diary-mark-included-diary-files)

(provide 'arche-log)
