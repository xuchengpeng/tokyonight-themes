;;; tokyonight-day-theme.el --- TokyoNight Day. -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'tokyonight-themes)

(defconst tokyonight-day-base-colors
  '((bg "#e1e2e7")
    (bg-dark "#d0d5e3")
    (bg-dark1 "#c1c9df")
    (bg-hl "#c4c8da")
    (blue0 "#7890dd")
    (blue "#2e7de9")
    (blue1 "#188092")
    (blue2 "#07879d")
    (blue5 "#006a83")
    (blue6 "#2e5857")
    (blue7 "#92a6d5")
    (comment "#848cb5")
    (cyan "#007197")
    (dark3 "#8990b3")
    (dark5 "#68709a")
    (fg "#3760bf")
    (fg-dark "#6172b0")
    (fg-gutter "#a8aecb")
    (green "#587539")
    (green1 "#387068")
    (green2 "#38919f")
    (magenta "#9854f1")
    (magenta2 "#d20065")
    (orange "#b15c00")
    (purple "#7847bd")
    (red "#f52a65")
    (red1 "#c64343")
    (teal "#118c74")
    (terminal-black "#a1a6c5")
    (yellow "#8c6c3e"))
  "Tokyonight day base colors.")

(defconst tokyonight-day-palette
  (append
   (let* ((base-colors tokyonight-day-base-colors)
          (bg-main (car (alist-get 'bg base-colors)))
          (six-colors (seq-filter
                       (lambda (color)
                         (memq (car color) '(red green yellow blue purple cyan)))
                       base-colors))
          (derived-colors nil))
     (pcase-dolist (`(,name ,value) six-colors)
       (push (list (intern (format "%s-warmer" name)) (tokyonight-themes-darken (tokyonight-themes-blend value "#ff0000" 0.9) 20)) derived-colors)
       (push (list (intern (format "%s-cooler" name)) (tokyonight-themes-darken (tokyonight-themes-blend value "#0000ff" 0.9) 20)) derived-colors)
       (push (list (intern (format "%s-faint" name)) (tokyonight-themes-darken value 10)) derived-colors)
       (push (list (intern (format "%s-intense" name)) (tokyonight-themes-lighten value 5)) derived-colors)
       (push (list (intern (format "bg-%s-intense" name)) (tokyonight-themes-lighten value 35)) derived-colors)
       (push (list (intern (format "bg-%s-subtle" name)) (tokyonight-themes-lighten value 55))  derived-colors)
       (push (list (intern (format "bg-%s-nuanced" name)) (tokyonight-themes-lighten value 75)) derived-colors))
     (push (list (intern "highlight") (tokyonight-themes-darken bg-main 5)) derived-colors)
     (append
      base-colors
      derived-colors))
   tokyonight-themes-common-palette-mappings)
  "Tokyonight day palette.")

(defcustom tokyonight-day-palette-overrides nil
  "Overrides for `tokyonight-day-palette'."
  :group 'tokyonight-themes
  :type 'alist)

(modus-themes-theme
 'tokyonight-day
 'tokyonight-themes
 "Tokyonight day."
 'light
 'modus-operandi-palette
 'tokyonight-day-palette
 'tokyonight-day-palette-overrides)

;;; tokyonight-day-theme.el ends here
