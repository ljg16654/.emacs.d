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

;; (icalendar-import-file "~/canvassync/ics_feed/user_ZNPM8DdwWnHRg6gfFRMtg9r05mmgTuessZDEmjns.ics" "~/canvassync/ics_feed/canvas_diary")

(add-hook 'diary-list-entries-hook 'diary-include-other-diary-files)
(add-hook 'diary-mark-entries-hook 'diary-mark-included-diary-files)

(provide 'arche-log)
