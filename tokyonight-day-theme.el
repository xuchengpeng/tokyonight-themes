;;; tokyonight-day-theme.el --- TokyoNight Day. -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(eval-and-compile
  (unless (and (fboundp 'require-theme)
               load-file-name
               (equal (file-name-directory load-file-name)
                      (expand-file-name "themes/" data-directory))
               (require-theme 'tokyonight-themes t))
    (require 'tokyonight-themes))

  ;;;###theme-autoload
  (deftheme tokyonight-day
    "TokyoNight Night."
    :background-mode 'light
    :kind 'color-scheme
    :family 'tokyonight)

  (defconst tokyonight-day-palette
    '((bg . "#e1e2e7")
      (bg-dark . "#d0d5e3")
      (bg-dark1 . "#c1c9df")
      (bg-hl . "#c4c8da")
      (blue0 . "#7890dd")
      (blue . "#2e7de9")
      (blue1 . "#188092")
      (blue2 . "#07879d")
      (blue5 . "#006a83")
      (blue6 . "#2e5857")
      (blue7 . "#92a6d5")
      (comment . "#848cb5")
      (cyan . "#007197")
      (dark3 . "#8990b3")
      (dark5 . "#68709a")
      (fg . "#3760bf")
      (fg-dark . "#6172b0")
      (fg-gutter . "#a8aecb")
      (green . "#587539")
      (green1 . "#387068")
      (green2 . "#38919f")
      (magenta . "#9854f1")
      (magenta2 . "#d20065")
      (orange . "#b15c00")
      (purple . "#7847bd")
      (red . "#f52a65")
      (red1 . "#c64343")
      (teal . "#118c74")
      (terminal-black . "#a1a6c5")
      (yellow . "#8c6c3e"))
    "TokyoNight day palette.")

  (defcustom tokyonight-day-palette-overrides nil
    "Overrides for `tokyonight-day-palette'."
    :group 'tokyonight-themes
    :type 'alist)

  (tokyonight-themes-theme tokyonight-day
                           tokyonight-day-palette
                           tokyonight-day-palette-overrides)

  (provide-theme 'tokyonight-day))
;;; tokyonight-day-theme.el ends here
