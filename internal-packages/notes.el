;;; package --- Summary;

;;; Commentary:

;;; Code:

(defconst root-directory (concat user-emacs-directory "personal-notes"))

(defun note-maybe-create-root-directory ()
  "Create notes directory."
  (if (file-directory-p root-directory) t
    (make-directory root-directory)))

(defun note-create-file (filename)
  "Create new note by FILENAME."
  (interactive "sNote file: ")
  (note-maybe-create-root-directory)
  (let* ((complete-filename (concat filename ".txt"))
	(full-path-file (concat root-directory "/" complete-filename)))
    (make-empty-file full-path-file)
    (find-file full-path-file)
    (message "File created.")))

(defun note-open (filename)
  "Choose note to open.  By FILENAME."
  (interactive
   (list (read-file-name "Note: " root-directory)))
  (find-file filename))

(global-set-key "\C-xnc" 'note-create-file)
(global-set-key "\C-xno" 'note-open)

;;; notes.el ends here
