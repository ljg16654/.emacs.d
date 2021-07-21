;;* calendar
(setq calendar-longitude 121.5
      calendar-latitude 31.2)
;;* diary
(setq diary-file (file-truename (concat user-emacs-directory "diary")))

;;;###autoload
(defun arche-toggle-diary ()
  (interactive)
  (let
      ((bufn "*Fancy Diary Entries*"))
      (if (get-buffer bufn)    
	(kill-buffer bufn)
      (diary 3))))

(global-set-key (kbd "s-d") #'arche-toggle-diary)
(global-set-key (kbd "s-a") #'org-agenda-list) 
(global-set-key (kbd "s-A") #'org-cycle-agenda-files)

;;* appointment
(setq
 ;; disable audible reminder
 appt-audible nil
 ;; In modeline, display number of minutes left to the appointment
 appt-display-mode-line t
 appt-message-warning-time 60)

(appt-activate t)

;;;###autoload
(defun my-refresh-canvas-ics ()
  (interactive)
  (let
      ((canvas-calendar-feed-url "https://www.umjicanvas.com/feeds/calendars/user_ZNPM8DdwWnHRg6gfFRMtg9r05mmgTuessZDEmjns.ics")
       (icalendar-fn "~/canvassync/ics_feed/canvas_export.ics")
       (diary-fn "~/canvassync/ics_feed/canvas_diary"))
    (progn
      (if (f-file-p icalendar-fn) (f-delete icalendar-fn))
      (url-copy-file canvas-calendar-feed-url icalendar-fn)
      (if (f-file-p diary-fn) (f-delete diary-fn))
      (icalendar-import-file icalendar-fn diary-fn))))

(add-hook 'diary-list-entries-hook 'diary-include-other-diary-files)
(add-hook 'diary-mark-entries-hook 'diary-mark-included-diary-files)

(use-package calfw
  :commands cfw:open-org-agenda
  :config
  (use-package calfw-org
    :config
    (setq cfw:org-agenda-schedule-args '())))

(provide 'arche-log)
