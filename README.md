# tokyonight-themes

> A clean dark Visual Studio Code theme that celebrates the lights of Downtown [Tokyo at night](https://www.google.com/search?q=tokyo+night&newwindow=1&sxsrf=ACYBGNRiOGCstG_Xohb8CgG5UGwBRpMIQg:1571032079139&source=lnms&tbm=isch&sa=X&ved=0ahUKEwiayIfIhpvlAhUGmuAKHbfRDaIQ_AUIEigB&biw=1280&bih=666&dpr=2).

Tokyo Night theme was firstly published as a plugin for Visual Studio Code, now it has many [other ports](https://github.com/enkia/tokyo-night-vscode-theme#other-ports).

Rawley make a [tokyo-theme.el](https://github.com/rawleyfowler/tokyo-theme.el) for GNU Emacs, but it is unmaintained and has not support any popular packages for GNU Emacs we often use.

So I want to make it for myself, The theme templates were taken from [modus-themes](https://github.com/protesilaos/modus-themes), and the color palettes were taken from [tokyonight.nvim](https://github.com/folke/tokyonight.nvim), these two themes are very popular and awesome with GNU Emacs or [Neovim](https://github.com/neovim/neovim).

This theme has four color palettes, as same sa tokyonight.nvim. I have add support with some popular packages which I often use with GNU Emacs, like Corfu, vertico, orderless, dired, diff-hl, hl-todo, multiple-cursors, symbol-overlay, vundo and so on.

If you like it, clone the theme, and add support for your plugins into the theme code. Also, you can use theme colors in code with `tokyonight-themes-with-colors`.

For example, add support for git-gutter-fr package.

```elisp
(tokyonight-themes-with-colors
  (custom-set-faces
    `(git-gutter-fr:added ((,c :foreground ,green)))
    `(git-gutter-fr:deleted ((,c :foreground ,red)))
    `(git-gutter-fr:modified ((,c :foreground ,yellow)))))
```

Evaluate the code with a function after the tokyonight-themes load.

If you want to change the color palettes, we have a option for palette overrides. Customize `tokyonight-<style>-palette-overrides` before you load the tokyonight-themes, style is an choice with storm, moon, night or day.

For example, change the blue and cyan color for tokyonight-day-theme.

```elisp
(setq tokyonight-day-palette-overrides
      '((blue . "#2e7de9")
        (cyan . "#007197")))
```
### Installing the theme

1. Unzip files of this repo into the `~/.emacs.d/themes/` directory.
2. Make sure the directory is added to the custom theme load path:
    ```elisp
    (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
    ```
3. Load the `tokyonight-themes.el` file before activating the theme:
    ```elisp
    (load-file "~/.emacs.d/themes/tokyonight-themes.el")
    ```
4. Activate the theme:
    ```elisp
    (load-theme 'tokyonight-moon t)
    ```

Now the theme should work correctly.
