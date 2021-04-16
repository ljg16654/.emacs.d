;;* calendar
(setq calendar-longitude 121.5
      calendar-latitude 31.2)
;;* diary
(setq diary-file (file-truename (concat user-emacs-directory "diary")))

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

(provide 'arche-log)
