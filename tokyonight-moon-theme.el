;;; tokyonight-moon-theme.el --- TokyoNight Moon. -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'tokyonight-themes)

(defconst tokyonight-moon-base-colors
  '((bg "#222436")
    (bg-dark "#1e2030")
    (bg-dark1 "#191b29")
    (bg-hl "#2f334d")
    (blue0 "#3e68d7")
    (blue "#82aaff")
    (blue1 "#65bcff")
    (blue2 "#0db9d7")
    (blue5 "#89ddff")
    (blue6 "#b4f9f8")
    (blue7 "#394b70")
    (comment "#7a88cf")
    (cyan "#86e1fc")
    (dark3 "#545c7e")
    (dark5 "#737aa2")
    (fg "#c8d3f5")
    (fg-dark "#828bb8")
    (fg-gutter "#3b4261")
    (green "#c3e88d")
    (green1 "#4fd6be")
    (green2 "#41a6b5")
    (magenta "#c099ff")
    (magenta2 "#ff007c")
    (orange "#ff966c")
    (purple "#fca7ea")
    (red "#ff757f")
    (red1 "#c53b53")
    (teal "#4fd6be")
    (terminal-black "#444a73")
    (yellow "#ffc777"))
  "Tokyonight moon base colors.")

(defconst tokyonight-moon-palette
  (append
   (let* ((base-colors tokyonight-moon-base-colors)
          (bg-main (car (alist-get 'bg base-colors)))
          (six-colors (seq-filter
                       (lambda (color)
                         (memq (car color) '(red green yellow blue purple cyan)))
                       base-colors))
          (derived-colors nil))
     (pcase-dolist (`(,name ,value) six-colors)
       (push (list (intern (format "%s-warmer" name)) (tokyonight-themes-lighten (tokyonight-themes-blend value "#ff0000" 0.9) 20)) derived-colors)
       (push (list (intern (format "%s-cooler" name)) (tokyonight-themes-lighten (tokyonight-themes-blend value "#0000ff" 0.9) 20)) derived-colors)
       (push (list (intern (format "%s-faint" name)) (tokyonight-themes-lighten value 10)) derived-colors)
       (push (list (intern (format "%s-intense" name)) (tokyonight-themes-darken value 5)) derived-colors)
       (push (list (intern (format "bg-%s-intense" name)) (tokyonight-themes-darken value 35)) derived-colors)
       (push (list (intern (format "bg-%s-subtle" name)) (tokyonight-themes-darken value 55))  derived-colors)
       (push (list (intern (format "bg-%s-nuanced" name)) (tokyonight-themes-darken value 75)) derived-colors))
     (push (list (intern "highlight") (tokyonight-themes-lighten bg-main 5)) derived-colors)
     (append
      base-colors
      derived-colors))
   tokyonight-themes-common-palette-mappings)
  "Tokyonight moon palette.")

(defcustom tokyonight-moon-palette-overrides nil
  "Overrides for `tokyonight-moon-palette'."
  :group 'tokyonight-themes
  :type 'alist)

(modus-themes-theme
 'tokyonight-moon
 'tokyonight-themes
 "Tokyonight moon."
 'dark
 'modus-vivendi-palette
 'tokyonight-moon-palette
 'tokyonight-moon-palette-overrides)

;;; tokyonight-moon-theme.el ends here
