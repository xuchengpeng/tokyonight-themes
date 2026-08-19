;;; tokyonight-themes.el --- TokyoNight themes. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(unless (require 'modus-themes nil t)
  (require-theme 'modus-themes))
(eval-when-compile (require 'subr-x))

(defgroup tokyonight-themes ()
  "Tokyonight themes."
  :group 'faces
  :group 'modus-themes
  :prefix "tokyonight-themes-"
  :tag "Tokyonight Themes")

(defconst tokyonight-themes-light-themes
  '(tokyonight-day)
  "List of symbols with the light Tokyonight themes.")

(defconst tokyonight-themes-dark-themes
  '(tokyonight-night tokyonight-storm tokyonight-moon)
  "List of symbols with the dark Tokyonight themes.")

(defvaralias 'tokyonight-themes-collection 'tokyonight-themes-items
  "Alias of `tokyonight-themes-items'.")

(defconst tokyonight-themes-items
  (append tokyonight-themes-light-themes tokyonight-themes-dark-themes)
  "Symbols of the Tokyonight themes.")

(defconst tokyonight-themes-common-palette-mappings
  '(
    ;; Basic values
    (bg-main bg)
    (bg-dim bg-dark)
    (fg-main fg)
    (fg-dim fg-dark)
    (fg-alt fg-gutter)
    (bg-active bg-dark1)
    (bg-inactive bg-dark)
    (border dark3)

    ;; Common accent foregrounds

    (magenta         purple)
    (magenta-warmer  purple-warmer)
    (magenta-cooler  purple-cooler)
    (magenta-faint   purple-faint)
    (magenta-intense purple-intense)

    ;; Common accent backgrounds

    (bg-magenta-intense bg-purple-intense)
    (bg-magenta-subtle bg-purple-subtle)
    (bg-magenta-nuanced bg-purple-nuanced)

    ;; Graphs

    (bg-graph-red-0 bg-red-intense)
    (bg-graph-red-1 bg-red-subtle)
    (bg-graph-green-0 bg-green-intense)
    (bg-graph-green-1 bg-green-subtle)
    (bg-graph-yellow-0 bg-yellow-intense)
    (bg-graph-yellow-1 bg-yellow-subtle)
    (bg-graph-blue-0 bg-blue-intense)
    (bg-graph-blue-1 bg-blue-subtle)
    (bg-graph-magenta-0 bg-magenta-intense)
    (bg-graph-magenta-1 bg-magenta-subtle)
    (bg-graph-cyan-0 bg-cyan-intense)
    (bg-graph-cyan-1 bg-cyan-subtle)

    ;; Special purpose

    (bg-completion bg-hl)
    (bg-popup bg-dark)
    (bg-hover highlight)
    (bg-hover-secondary bg-dark1)
    (bg-hl-line highlight)
    (bg-region terminal-black)
    (fg-region fg)

    (bg-mode-line-active bg-dark1)
    (fg-mode-line-active fg)
    (border-mode-line-active bg-mode-line-active)
    (bg-mode-line-inactive bg-dark)
    (fg-mode-line-inactive fg-dark)
    (border-mode-line-inactive bg-mode-line-inactive)

    (modeline-err red)
    (modeline-warning yellow)
    (modeline-info blue)

    (bg-tab-bar bg-dim)
    (bg-tab-current bg-main)
    (bg-tab-other bg-inactive)

    (fg-line-number-inactive fg-dark)
    (fg-line-number-active fg)
    (bg-line-number-inactive unspecified)
    (bg-line-number-active unspecified)

    ;; Diffs

    (bg-diff-context highlight)

    ;; Paren match

    (bg-paren-match bg-cyan-intense)
    (bg-paren-expression bg-cyan-nuanced)
    (underline-paren-match unspecified)

    ;; General mappings

    (cursor fg)
    (fringe unspecified)

    ;; Code mappings

    (builtin purple)
    (constant orange)
    (docstring green2)
    (fnname blue)
    (fnname-call blue)
    (keyword magenta)
    (number orange)
    (operator magenta)
    (preprocessor cyan)
    (property yellow)
    (rx-backslash yellow)
    (rx-construct magenta)
    (string green)
    (type blue1)
    (variable yellow)
    (variable-use yellow)

    ;; Link mappings

    (fg-link blue)
    (underline-link blue)
    (fg-link-visited blue2)
    (underline-link-visited blue2)

    ;; Prose mappings

    (fg-prose-code cyan)
    (fg-prose-macro magenta)
    (fg-prose-verbatim magenta)
    (prose-table-formula magenta)
    (prose-tag magenta)

    ;; Heading mappings

    (fg-heading-0 blue1)
    (fg-heading-1 red)
    (fg-heading-2 orange)
    (fg-heading-3 yellow)
    (fg-heading-4 green)
    (fg-heading-5 blue2)
    (fg-heading-6 blue5)
    (fg-heading-7 purple)
    (fg-heading-8 red1))
  "Common palette mappings for the Tokyonight themes.")

(defconst tokyonight-themes-with-properties
  '((tokyonight-day tokyonight-themes "Tokyonight day." light modus-operandi-palette tokyonight-day-palette tokyonight-day-palette-overrides)
    (tokyonight-night tokyonight-themes "Tokyonight night." dark modus-vivendi-palette tokyonight-night-palette tokyonight-night-palette-overrides)
    (tokyonight-storm tokyonight-themes "Tokyonight storm." dark modus-vivendi-palette tokyonight-storm-palette tokyonight-storm-palette-overrides)
    (tokyonight-moon tokyonight-themes "Tokyonight moon." dark modus-vivendi-palette tokyonight-moon-palette tokyonight-moon-palette-overrides)))

(defvar tokyonight-themes--declared-p nil)

(defun tokyonight-themes-declare-themes ()
  "Declare the Tokyonight themes."
  (unless tokyonight-themes--declared-p
    (dolist (theme tokyonight-themes-with-properties)
      (apply #'modus-themes-declare theme)
      (modus-themes-register (car theme)))
    (setq tokyonight-themes--declared-p t)))

(tokyonight-themes-declare-themes)

;;;###autoload
(define-minor-mode tokyonight-themes-take-over-modus-themes-mode
  "When enabled, all Modus themes commands consider only Tokyonight themes.
Alternatively, use the commands `tokyonight-themes-rotate',
`tokyonight-themes-select', `tokyonight-themes-load-random',
`tokyonight-themes-load-random-dark', `tokyonight-themes-load-random-light',
`tokyonight-themes-list-colors', `tokyonight-themes-list-colors-current'.
They are all designed to only consider Tokyonight themes."
  :global t
  :init-value nil)

(cl-defmethod modus-themes-get-themes (&context (tokyonight-themes-take-over-modus-themes-mode (eql t)))
  "Return Tokyonight themes per `tokyonight-themes-take-over-modus-themes-mode'."
  (if-let* ((themes (modus-themes-get-all-known-themes 'tokyonight-themes))
            (sorted-a-z (sort themes #'string-lessp))
            (sorted-light-dark (modus-themes-sort sorted-a-z 'light)))
      sorted-light-dark
    tokyonight-themes-items))

;;;###autoload (autoload 'tokyonight-themes-toggle "tokyonight-themes")
(modus-themes-define-derivative-command tokyonight-themes toggle)

;;;###autoload (autoload 'tokyonight-themes-rotate "tokyonight-themes")
(modus-themes-define-derivative-command tokyonight-themes rotate)

;;;###autoload (autoload 'tokyonight-themes-select "tokyonight-themes")
(modus-themes-define-derivative-command tokyonight-themes select)

;;;###autoload (autoload 'tokyonight-themes-load-random "tokyonight-themes")
(modus-themes-define-derivative-command tokyonight-themes load-random)

;;;###autoload (autoload 'tokyonight-themes-load-random-dark "tokyonight-themes")
(modus-themes-define-derivative-command tokyonight-themes load-random-dark)

;;;###autoload (autoload 'tokyonight-themes-load-random-light "tokyonight-themes")
(modus-themes-define-derivative-command tokyonight-themes load-random-light)

;;;###autoload (autoload 'tokyonight-themes-list-colors "tokyonight-themes")
(modus-themes-define-derivative-command tokyonight-themes list-colors)

;;;###autoload (autoload 'tokyonight-themes-list-colors-current "tokyonight-themes")
(modus-themes-define-derivative-command tokyonight-themes list-colors-current)

;;;###autoload
(defun tokyonight-themes-color-blend (a b &optional alpha)
  "Blend the two colors A and B in linear space with ALPHA.
A and B should be lists (RED GREEN BLUE), where each element is
between 0.0 and 1.0, inclusive.  ALPHA controls the influence A
has on the result and should be between 0.0 and 1.0, inclusive.

For instance:

   (tokyonight-themes-color-blend \\='(1 0.5 1) \\='(0 0 0) 0.75)
      => (0.75 0.375 0.75)"
  (setq alpha (or alpha 0.5))
  (let (blend)
    (dotimes (i 3)
      (push (+ (* (nth i a) alpha) (* (nth i b) (- 1 alpha))) blend))
    (nreverse blend)))

;;;###autoload
(defun tokyonight-themes-blend (a b &optional alpha)
  "Blend the two colors A and B in linear space with ALPHA (a float between 0 and 1)."
  (pcase-let ((`(,r ,g ,b) (tokyonight-themes-color-blend (color-name-to-rgb a) (color-name-to-rgb b) alpha)))
    (color-rgb-to-hex r g b 2)))

;;;###autoload
(defun tokyonight-themes-lighten (color value)
  "Lighten COLOR by VALUE% (0–100)."
  (let* ((alpha (/ value 100.0)))
    (tokyonight-themes-blend color "#ffffff" (- 1 alpha))))

;;;###autoload
(defun tokyonight-themes-darken (color value)
  "Darken COLOR by VALUE% (0–100)."
  (let* ((alpha (/ value 100.0)))
    (tokyonight-themes-blend color "#000000" (- 1 alpha))))

;;;###autoload
(when load-file-name
  (let ((dir (file-name-directory load-file-name)))
    (add-to-list 'custom-theme-load-path dir)))

(provide 'tokyonight-themes)
;;; tokyonight-themes.el ends here
