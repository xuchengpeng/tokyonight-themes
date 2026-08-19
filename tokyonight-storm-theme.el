;;; tokyonight-storm-theme.el --- TokyoNight Storm. -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'tokyonight-themes)

(defconst tokyonight-storm-base-colors
  '((bg "#24283b")
    (bg-dark "#1f2335")
    (bg-dark1 "#1b1e2d")
    (bg-hl "#292e42")
    (blue0 "#3d59a1")
    (blue "#7aa2f7")
    (blue1 "#2ac3de")
    (blue2 "#0db9d7")
    (blue5 "#89ddff")
    (blue6 "#b4f9f8")
    (blue7 "#394b70")
    (comment "#565f89")
    (cyan "#7dcfff")
    (dark3 "#545c7e")
    (dark5 "#737aa2")
    (fg "#c0caf5")
    (fg-dark "#a9b1d6")
    (fg-gutter "#3b4261")
    (green "#9ece6a")
    (green1 "#73daca")
    (green2 "#41a6b5")
    (magenta "#bb9af7")
    (magenta2 "#ff007c")
    (orange "#ff9e64")
    (purple "#9d7cd8")
    (red "#f7768e")
    (red1 "#db4b4b")
    (teal "#1abc9c")
    (terminal-black "#414868")
    (yellow "#e0af68"))
  "Tokyonight storm base colors.")

(defconst tokyonight-storm-palette
  (append
   (let* ((base-colors tokyonight-storm-base-colors)
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
  "Tokyonight storm palette.")

(defcustom tokyonight-storm-palette-overrides nil
  "Overrides for `tokyonight-storm-palette'."
  :group 'tokyonight-themes
  :type 'alist)

(modus-themes-theme
 'tokyonight-storm
 'tokyonight-themes
 "Tokyonight storm."
 'dark
 'modus-vivendi-palette
 'tokyonight-storm-palette
 'tokyonight-storm-palette-overrides)

;;; tokyonight-storm-theme.el ends here
