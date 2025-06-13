;;; tokyonight-moon-theme.el --- TokyoNight Moon. -*- lexical-binding: t -*-
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
  (deftheme tokyonight-moon
    "TokyoNight Night."
    :background-mode 'dark
    :kind 'color-scheme
    :family 'tokyonight)

  (defconst tokyonight-moon-palette
    '((bg . "#222436")
      (bg-dark . "#1e2030")
      (bg-dark1 . "#191b29")
      (bg-hl . "#2f334d")
      (blue0 . "#3e68d7")
      (blue . "#82aaff")
      (blue1 . "#65bcff")
      (blue2 . "#0db9d7")
      (blue5 . "#89ddff")
      (blue6 . "#b4f9f8")
      (blue7 . "#394b70")
      (comment . "#7a88cf")
      (cyan . "#86e1fc")
      (dark3 . "#545c7e")
      (dark5 . "#737aa2")
      (fg . "#c8d3f5")
      (fg-dark . "#828bb8")
      (fg-gutter . "#3b4261")
      (green . "#c3e88d")
      (green1 . "#4fd6be")
      (green2 . "#41a6b5")
      (magenta . "#c099ff")
      (magenta2 . "#ff007c")
      (orange . "#ff966c")
      (purple . "#fca7ea")
      (red . "#ff757f")
      (red1 . "#c53b53")
      (teal . "#4fd6be")
      (terminal-black . "#444a73")
      (yellow . "#ffc777"))
    "TokyoNight moon palette.")

  (defcustom tokyonight-moon-palette-overrides nil
    "Overrides for `tokyonight-moon-palette'."
    :group 'tokyonight-themes
    :type 'alist)

  (tokyonight-themes-theme tokyonight-moon
                           tokyonight-moon-palette
                           tokyonight-moon-palette-overrides)

  (provide-theme 'tokyonight-moon))
;;; tokyonight-moon-theme.el ends here
