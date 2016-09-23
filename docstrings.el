(require 'cl)

(defun insert-docstring (sym)
  (when (and (functionp sym) (documentation sym))
    (insert (format "<a name=\"%s\"></a>\n" (symbol-name sym)))
    (insert (format "<h3>Function: %s</h3>\n" (symbol-name sym)))
    (insert (documentation sym))))

(defun fix-formatting ()
  (goto-char (point-min))
  (while (re-search-forward "\n\n" nil t)
    (replace-match "</p>\n<p>\n")))

(defun docstrings ()
  (with-temp-buffer
    (find-file "index.html")
    (erase-buffer)
    (mapatoms #'insert-docstring)
    (fix-formatting)
    (save-buffer)))
