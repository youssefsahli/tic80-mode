;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this file; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
;; 02110-1301, USA.
;;
;; Commentary:
;;
;; This projects adds a minor mode for GNU Emacs, and configures a keymap
;; for a faster testing using the TIC-80 executable.
;;
;; Usage:
;;
;; Put this file on your Emacs lisp path and add this to your '.emacs' :
;;
;; (require `tic80)
;;
;; You can enable the minor mode with (tic80-minor-mode t)
;;
;; Code:

(defconst tic80-minor-mode-version-number "1.0"
  "The version number of the tic-80 minor mode.")

(defvar tic80-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "M-p") `tic80-launch-with-current-file)
    map)
  "A Keymap for tic-80 minor mode.")

(defgroup tic80 nil
  "Customization group for the tic80 minor mode"
  :prefix "tic80-"
  :group `tic80)

;;;###autoload
(define-minor-mode tic80-minor-mode
  "toggles the tic80 minor mode"
  :init-value nil
  :lighter " TIC-80"
  :group `tic80
  :keymap tic80-minor-mode-map)

(defcustom tic80-path (executable-find "tic80")
  "Path to tic80"
  :type `string
  :group `tic80)

(defun tic80-launch-with-current-file ()
  "Launch the TIC-80 Fantasy Console and run the current file"
  (interactive)
  (save-buffer)
  (when (get-buffer "*tic80-output*")
    (display-buffer (current-buffer)))
  (start-process "tic80-process"
		 "*tic80-output*"
		 tic80-path
		 "--fs" default-directory
		 (buffer-file-name) "--skip"))

(provide `tic80)

;;; tic80.el ends here
