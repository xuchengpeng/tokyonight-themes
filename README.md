# tokyonight-themes

> A clean dark Visual Studio Code theme that celebrates the lights of Downtown [Tokyo at night](https://www.google.com/search?q=tokyo+night&newwindow=1&sxsrf=ACYBGNRiOGCstG_Xohb8CgG5UGwBRpMIQg:1571032079139&source=lnms&tbm=isch&sa=X&ved=0ahUKEwiayIfIhpvlAhUGmuAKHbfRDaIQ_AUIEigB&biw=1280&bih=666&dpr=2).

Tokyo Night theme was firstly published as a plugin for Visual Studio Code, now it has many [other ports](https://github.com/tokyo-night/tokyo-night-vscode-theme#other-ports).

The theme templates adapt from [modus-themes](https://github.com/protesilaos/modus-themes), and the color palettes adapt from [tokyonight.nvim](https://github.com/folke/tokyonight.nvim), these two themes are very popular and awesome with GNU Emacs or [Neovim](https://github.com/neovim/neovim).

Load the theme in your configuration:

``` elisp
(use-package modus-themes
  :ensure t)
(use-package tokyonight-themes
  :load-path "d:/github/tokyonight-themes/"
  :config
  (tokyonight-themes-take-over-modus-themes-mode 1)
  (modus-themes-load-theme 'tokyonight-moon)
  (setq modus-themes-to-toggle '(tokyonight-moon tokyonight-day))
  (keymap-global-set "<f5>" #'modus-themes-toggle))
```
