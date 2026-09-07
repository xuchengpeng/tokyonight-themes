;;; tokyonight-themes.el --- TokyoNight themes. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'seq)
(eval-when-compile (require 'subr-x))

(defgroup tokyonight-themes nil
  "TokyoNight themes."
  :group 'faces)

(defcustom tokyonight-themes-to-toggle '(tokyonight-day tokyonight-moon)
  "Specify two themes for the `tokyonight-themes-toggle' command."
  :group 'tokyonight-themes)

(defun tokyonight-themes-load-theme (theme)
  "Load THEME while disabling other themes and return THEME."
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme :no-confirm)
  theme)

;;;###autoload
(defun tokyonight-themes-toggle ()
  "Toggle between the tow `tokyonight-themes-to-toggle'."
  (interactive)
  (pcase-let ((`(,one ,two) tokyonight-themes-to-toggle))
    (if (eq (car custom-enabled-themes) one)
        (tokyonight-themes-load-theme two)
      (tokyonight-themes-load-theme one))))

;;;###autoload
(defmacro tokyonight-themes-define-theme (name background-mode &optional description)
  "Define theme with NAME, BACKGROUND-MODE and optional DESCRIPTION."
  (declare (indent 0))
  (unless (memq background-mode '(light dark))
    (error "The BACKGROUND-MODE must be either `light' or `dark'"))
  (if-let* ((palette (symbol-value (intern (format "%s-palette" name)))))
      (let ((theme-exists-p (get name 'theme-feature)))
        `(progn
           ,@(unless theme-exists-p
               (list `(custom-declare-theme
                       ',name 'tokyonight-themes
                       ,(or description (format "TokyoNight %s theme." background-mode))
                       (list :kind 'color-scheme :background-mode ',background-mode :family 'tokyonight))))
           (let ,palette
             (custom-theme-set-faces
              ',name
              ;; basic faces
              `(default ((t :foreground ,fg :background ,bg)))
              '(bold ((t :weight bold)))
              '(italic ((t :slant italic)))
              '(bold-italic ((t :inherit (bold italic))))
              '(underline ((t :underline t)))
              `(cursor ((t :background ,fg)))
              `(fringe ((t :background ,bg :foreground ,fg-gutter)))
              `(menu ((t :background ,bg-dark :foreground ,fg)))
              `(scroll-bar ((t :background ,bg-dark :foreground ,fg-dark)))
              `(tool-bar ((t :background ,bg-dark :foreground ,fg)))
              `(button ((t :foreground ,teal :underline t)))
              `(link ((t :foreground ,teal :underline t)))
              `(link-visited ((t :foreground ,magenta :underline t)))
              `(shadow ((t :foreground ,comment)))
              `(minibuffer-prompt ((t :foreground ,cyan :background unspecified)))
              `(region ((t :background ,dark3 :foreground ,fg :extend t)))
              `(secondary-selection ((t :background ,bg-hl :foreground unspecified)))
              `(trailing-whitespace ((t :foreground ,fg :background ,red1)))
              `(border ((t :background ,fg-gutter :foreground ,fg)))
              `(vertical-border ((t :foreground ,terminal-black)))
              `(child-frame-border ((t :background ,fg-gutter :foreground ,fg)))
              `(tooltip ((t :background ,bg-dark :foreground ,fg)))
              `(highlight ((t :background ,bg-hl :foreground ,fg)))
              `(error ((t :foreground ,red1 :weight bold)))
              `(warning ((t :foreground ,yellow :weight bold)))
              `(success ((t :foreground ,green1 :weight bold)))
              `(help-argument-name ((t :foreground ,fg :slant italic)))
              `(help-key-binding ((t :foreground ,blue :weight bold)))

              ;; font-lock
              `(font-lock-bracket-face ((t :foreground ,fg-dark)))
              `(font-lock-builtin-face ((t :foreground ,blue1)))
              `(font-lock-comment-face ((t :inherit italic :foreground ,comment)))
              '(font-lock-comment-delimiter-face ((t :inherit font-lock-comment-face)))
              `(font-lock-constant-face ((t :foreground ,orange)))
              `(font-lock-delimiter-face ((t :foreground ,fg-dark)))
              `(font-lock-escape-face ((t :foreground ,blue5)))
              `(font-lock-doc-face ((t :foreground ,comment)))
              `(font-lock-doc-markup-face ((t :foreground ,dark5)))
              `(font-lock-function-name-face ((t :foreground ,blue)))
              `(font-lock-function-call-face ((t :foreground ,blue)))
              `(font-lock-keyword-face ((t :foreground ,magenta)))
              `(font-lock-negation-char-face ((t :foreground ,blue5)))
              `(font-lock-misc-punctuation-face ((t :foreground ,blue5)))
              `(font-lock-number-face ((t :foreground ,orange)))
              `(font-lock-operator-face ((t :foreground ,blue5)))
              `(font-lock-preprocessor-face ((t :foreground ,teal)))
              `(font-lock-property-name-face ((t :foreground ,teal)))
              `(font-lock-property-use-face ((t :foreground ,teal)))
              `(font-lock-punctuation-face ((t :foreground ,fg)))
              `(font-lock-regexp-grouping-backslash ((t :foreground ,blue6 :weight bold)))
              `(font-lock-regexp-grouping-construct ((t :foreground ,blue6 :weight bold)))
              `(font-lock-string-face ((t :foreground ,green)))
              `(font-lock-type-face ((t :foreground ,cyan)))
              `(font-lock-variable-name-face ((t :foreground ,fg)))
              `(font-lock-variable-use-face ((t :foreground ,fg)))
              `(font-lock-warning-face ((t :foreground ,yellow)))

              ;; ansi-color
              `(ansi-color-black ((t :background ,fg-gutter :foreground ,fg-gutter)))
              `(ansi-color-blue ((t :background ,blue :foreground ,blue)))
              '(ansi-color-bold ((t :inherit bold)))
              `(ansi-color-cyan ((t :background ,cyan :foreground ,cyan)))
              `(ansi-color-green ((t :background ,teal :foreground ,teal)))
              `(ansi-color-magenta ((t :background ,magenta :foreground ,magenta)))
              `(ansi-color-red ((t :background ,red :foreground ,red)))
              `(ansi-color-white ((t :background ,fg-dark :foreground ,fg-dark)))
              `(ansi-color-yellow ((t :background ,yellow :foreground ,yellow)))
              `(ansi-color-bright-black ((t :background ,terminal-black :foreground ,terminal-black)))
              `(ansi-color-bright-blue ((t :background ,blue :foreground ,blue)))
              `(ansi-color-bright-cyan ((t :background ,cyan :foreground ,cyan)))
              `(ansi-color-bright-green ((t :background ,teal :foreground ,teal)))
              `(ansi-color-bright-magenta ((t :background ,magenta :foreground ,magenta)))
              `(ansi-color-bright-red ((t :background ,red :foreground ,red)))
              `(ansi-color-bright-white ((t :background ,fg-dark :foreground ,fg-dark)))
              `(ansi-color-bright-yellow ((t :background ,yellow :foreground ,yellow)))

              ;; ace-window
              `(aw-background-face ((t :foreground ,comment)))
              `(aw-key-face ((t :foreground ,magenta2 :weight bold)))
              `(aw-leading-char-face ((t :foreground ,magenta2 :weight bold :height 1.5)))
              `(aw-minibuffer-leading-char-face ((t :foreground ,magenta2 :weight bold)))
              `(aw-mode-line-face ((t :foreground ,blue :weight bold)))

              ;; avy
              `(avy-background-face ((t :foreground ,comment)))
              `(avy-goto-char-timer-face ((t :background ,magenta2 :foreground ,bg)))
              `(avy-lead-face ((t :background ,magenta2 :foreground ,bg :weight bold)))
              `(avy-lead-face-0 ((t  :background ,blue :foreground ,bg :weight bold)))
              `(avy-lead-face-1 ((t :background ,dark5 :foreground ,bg :weight bold)))
              `(avy-lead-face-2 ((t :background ,teal :foreground ,bg :weight bold)))

              ;; bookmark
              `(bookmark-face ((t :foreground ,yellow)))
              '(bookmark-menu-bookmark ((t :inherit bold)))

              ;; calendar and diary
              `(calendar-today ((t :foreground ,blue :weight bold :underline t)))
              `(calendar-weekend-header ((t :foreground ,red)))
              `(calendar-weekday-header ((t :foreground ,teal)))
              `(calendar-month-header ((t :foreground ,magenta :weight bold)))
              `(holiday ((t :foreground ,orange)))
              `(diary ((t :foreground ,yellow)))

              ;; compilation
              `(compilation-error ((t :foreground ,red1 :weight bold)))
              `(compilation-warning ((t :foreground ,yellow :weight bold)))
              `(compilation-info ((t :foreground ,teal)))
              `(compilation-mode-line-exit ((t :foreground ,green :weight bold)))
              `(compilation-mode-line-fail ((t :foreground ,red :weight bold)))
              `(compilation-mode-line-run ((t :foreground ,blue :weight bold)))
              `(compilation-line-number ((t :foreground ,dark5)))
              `(compilation-column-number ((t :foreground ,dark5)))

              ;; completions
              `(completions-annotations ((t :foreground ,comment)))
              `(completions-common-part ((t :foreground ,blue :weight bold)))
              `(completions-first-difference ((t :foreground ,orange)))
              `(completions-highlight ((t :background ,bg-hl)))
              `(completions-group-title ((t :foreground ,magenta :weight bold :slant italic)))
              `(completions-group-separator ((t :foreground ,comment :strike-through t)))

              ;; corfu
              `(corfu-default ((t :foreground ,fg :background ,bg-dark)))
              `(corfu-current ((t :foreground ,fg :background ,bg-hl :weight bold)))
              `(corfu-bar ((t :background ,dark3)))
              `(corfu-border ((t :background ,fg-gutter)))
              `(corfu-annotations ((t :foreground ,comment)))
              `(corfu-deprecated ((t :foreground ,comment :strike-through t)))
              `(corfu-popupinfo ((t :foreground ,fg :background ,bg-dark)))

              ;; custom (M-x customize)
              `(custom-variable-tag ((t (:foreground ,blue :weight bold))))
              `(custom-group-tag ((t (:foreground ,blue :weight bold :height 1.2))))
              `(custom-group-tag-1 ((t (:foreground ,magenta :weight bold :height 1.2))))
              `(custom-state ((t (:foreground ,green))))
              `(custom-button ((t (:foreground ,fg :background ,bg-hl :box (:line-width 2 :color ,terminal-black :style released-button)))))
              `(custom-button-mouse ((t (:foreground ,fg :background ,dark3 :box (:line-width 2 :color ,terminal-black :style released-button)))))
              `(custom-button-pressed ((t (:foreground ,fg :background ,bg-hl :box (:line-width 2 :color ,terminal-black :style pressed-button)))))
              `(custom-changed ((t :foreground ,bg :background ,yellow)))
              `(custom-comment ((t :foreground ,comment)))
              '(custom-comment-tag ((t :inherit custom-comment)))
              `(custom-invalid ((t :foreground ,red :strike-through t)))
              '(custom-modified ((t :inherit custom-changed)))
              '(custom-themed ((t :inherit custom-changed)))
              '(custom-rogue ((t :inherit custom-invalid)))
              `(custom-set ((t :foreground ,teal)))

              ;; diff
              `(diff-added ((t :foreground ,green :background ,bg-hl)))
              `(diff-changed ((t :foreground ,yellow :background ,bg-hl)))
              '(diff-changed-unspecified ((t :inherit diff-changed)))
              `(diff-removed ((t :foreground ,red :background ,bg-hl)))
              '(diff-indicator-added ((t :inherit diff-added)))
              '(diff-indicator-changed ((t :inherit diff-changed)))
              '(diff-indicator-removed ((t :inherit diff-removed)))
              '(diff-refine-added ((t :inherit diff-added :inverse-video t)))
              '(diff-refine-changed ((t :inherit diff-changed :inverse-video t)))
              '(diff-refine-removed ((t :inherit diff-removed :inverse-video t)))
              '(diff-context (()))
              `(diff-error ((t :foreground ,red1 :weight bold)))
              '(diff-file-header ((t :weight bold)))
              `(diff-function ((t :background ,terminal-black)))
              '(diff-header (()))
              `(diff-hunk-header ((t :background ,terminal-black :weight bold)))
              '(diff-index ((t :slant italic)))
              '(diff-nonexistent ((t :weight bold)))

              ;; diff-hl
              `(diff-hl-change ((t :foreground ,bg :background ,yellow)))
              `(diff-hl-delete ((t :foreground ,bg :background ,red)))
              `(diff-hl-insert ((t :foreground ,bg :background ,green)))
              `(diff-hl-reverted-hunk-highlight ((t :foreground ,bg :background ,fg)))

              ;; dired
              `(dired-directory ((t :foreground ,blue :weight bold)))
              `(dired-flagged ((t :foreground ,red)))
              `(dired-header ((t :foreground ,magenta :weight bold)))
              `(dired-ignored ((t :foreground ,comment)))
              `(dired-mark ((t :foreground ,orange :weight bold)))
              `(dired-marked ((t :foreground ,magenta :weight bold)))
              `(dired-perm-write ((t :foreground ,fg-dark)))
              `(dired-symlink ((t :foreground ,cyan)))
              `(dired-warning ((t :foreground ,yellow :weight bold)))
              `(dired-broken-symlink ((t :foreground ,red :weight bold)))

              ;; ediff
              `(ediff-current-diff-A ((t (:foreground ,red :background ,bg-hl :extend t))))
              `(ediff-current-diff-B ((t (:foreground ,green :background ,bg-hl :extend t))))
              `(ediff-current-diff-C ((t (:foreground ,yellow :background ,bg-hl :extend t))))
              `(ediff-fine-diff-A ((t (:inherit ediff-current-diff-A :inverse-video t))))
              `(ediff-fine-diff-B ((t (:inherit ediff-current-diff-B :inverse-video t))))
              `(ediff-fine-diff-C ((t (:inherit ediff-current-diff-C :inverse-video t))))
              `(ediff-even-diff-A ((t (:background ,bg-hl :extend t))))
              `(ediff-even-diff-B ((t (:background ,bg-hl :extend t))))
              `(ediff-even-diff-C ((t (:background ,bg-hl :extend t))))
              `(ediff-odd-diff-A ((t (:background ,bg-hl :extend t))))
              `(ediff-odd-diff-B ((t (:background ,bg-hl :extend t))))
              `(ediff-odd-diff-C ((t (:background ,bg-hl :extend t))))

              ;; eglot
              `(eglot-highlight-symbol-face ((t :background ,bg-hl :weight bold)))
              `(eglot-inlay-hint-face ((t :foreground ,dark5 :height 0.9)))
              `(eglot-diagnostic-tag-unnecessary-face ((t :foreground ,comment :underline (:style wave :color ,dark5))))
              `(eglot-diagnostic-tag-deprecated-face ((t :foreground ,comment :strike-through ,dark5)))
              `(eglot-mode-line ((t :foreground ,blue)))

              ;; elfeed
              `(elfeed-log-date-face ((t :foreground ,cyan)))
              `(elfeed-log-debug-level-face ((t :foreground ,fg)))
              `(elfeed-log-error-level-face ((t :foreground ,red1 :weight bold)))
              `(elfeed-log-warn-level-face ((t :foreground ,yellow :weight bold)))
              `(elfeed-log-info-level-face ((t :foreground ,teal)))
              `(elfeed-search-date-face ((t :foreground ,cyan)))
              `(elfeed-search-feed-face ((t :foreground ,blue)))
              `(elfeed-search-filter-face ((t :foreground ,magenta :weight bold)))
              `(elfeed-search-last-update-face ((t :foreground ,dark5)))
              `(elfeed-search-tag-face ((t :foreground ,teal)))
              `(elfeed-search-title-face ((t :foreground ,comment)))
              '(elfeed-search-unread-count-face (( )))
              `(elfeed-search-unread-title-face ((t :foreground ,fg :weight bold)))
              `(elfeed-show-header-face ((t :foreground ,magenta)))
              `(elfeed-show-title-face ((t :foreground ,fg :weight bold)))
              `(elfeed-show-author-face ((t :foreground ,fg :weight bold)))
              `(elfeed-show-date-face ((t :foreground ,cyan)))
              `(elfeed-show-feed-face ((t :foreground ,blue)))
              `(elfeed-show-tags-face ((t :foreground ,teal)))

              ;; elisp semantic highlighting
              '(elisp-binding-variable (( )))
              '(elisp-bound-variable (( )))
              '(elisp-charset (( )))
              '(elisp-coding (( )))
              '(elisp-completion-category (( )))
              `(elisp-condition ((t :foreground ,red)))
              '(elisp-constant (( )))
              '(elisp-face (( )))
              '(elisp-free-variable (( )))
              '(elisp-group (( )))
              '(elisp-icon (( )))
              `(elisp-major-mode-name ((t :foreground ,blue1)))
              `(elisp-non-local-exit ((t :foreground ,yellow)))
              '(elisp-oclosure (( )))
              '(elisp-shadowing-variable (( )))
              `(elisp-shorthand-font-lock-face ((t :foreground ,teal)))
              '(elisp-special-variable-declaration (( )))
              `(elisp-symbol-at-mouse ((t :background ,bg-dark :foreground ,fg)))
              '(elisp-symbol-role (( )))
              '(elisp-theme (( )))
              '(elisp-thing (( )))
              '(elisp-type (( )))
              '(elisp-unknown-call ((t :inherit font-lock-function-call-face)))
              '(elisp-widget-type (( )))

              ;; eshell
              `(eshell-prompt ((t :foreground ,blue :weight bold)))
              `(eshell-ls-archive ((t :foreground ,magenta)))
              `(eshell-ls-backup ((t :foreground ,comment)))
              `(eshell-ls-clutter ((t :foreground ,comment)))
              `(eshell-ls-directory ((t :foreground ,blue :weight bold)))
              `(eshell-ls-executable ((t :foreground ,green)))
              `(eshell-ls-missing ((t :foreground ,red)))
              `(eshell-ls-product ((t :foreground ,fg-dark)))
              `(eshell-ls-readonly ((t :foreground ,dark5)))
              `(eshell-ls-special ((t :foreground ,orange :weight bold)))
              `(eshell-ls-symlink ((t :foreground ,cyan)))
              `(eshell-ls-unreadable ((t :foreground ,comment)))

              ;; flymake
              `(flymake-error ((t :underline (:style wave :color ,red1))))
              `(flymake-warning ((t :underline (:style wave :color ,yellow))))
              `(flymake-note ((t :underline (:style wave :color ,teal))))

              ;; flyspell
              `(flyspell-duplicate ((t :underline (:style wave :color ,yellow))))
              `(flyspell-incorrect ((t :underline (:style wave :color ,red1))))

              ;; hi-lock (M-x highlight-regexp)
              '(hi-aquamarine ((((class color) (min-colors 88) (background light))
                                :background "white" :foreground "#227f9f" :inverse-video t)
                               (((class color) (min-colors 88) (background dark))
                                :background "black" :foreground "#66cbdc" :inverse-video t)))
              '(hi-black-b ((t :inverse-video t)))
              `(hi-black-hb ((t :background ,bg :foreground ,fg-dark :inverse-video t)))
              '(hi-blue ((((class color) (min-colors 88) (background light))
                          :background "white" :foreground "#3366dd" :inverse-video t)
                         (((class color) (min-colors 88) (background dark))
                          :background "black" :foreground "#aaccff" :inverse-video t)))
              '(hi-blue-b ((t :inherit (bold hi-blue))))
              '(hi-green ((((class color) (min-colors 88) (background light))
                           :background "white" :foreground "#008a00" :inverse-video t)
                          (((class color) (min-colors 88) (background dark))
                           :background "black" :foreground "#66dd66" :inverse-video t)))
              '(hi-green-b ((t :inherit (bold hi-green))))
              '(hi-pink ((((class color) (min-colors 88) (background light))
                          :background "white" :foreground "#bd30aa" :inverse-video t)
                         (((class color) (min-colors 88) (background dark))
                          :background "black" :foreground "#ff88ee" :inverse-video t)))
              '(hi-red-b ((((class color) (min-colors 88) (background light))
                           :background "white" :foreground "#dd0000" :inverse-video t)
                          (((class color) (min-colors 88) (background dark))
                           :background "black" :foreground "#f06666" :inverse-video t)))
              '(hi-salmon ((((class color) (min-colors 88) (background light))
                            :background "white" :foreground "#af4f6f" :inverse-video t)
                           (((class color) (min-colors 88) (background dark))
                            :background "black" :foreground "#e08a50" :inverse-video t)))
              '(hi-yellow ((((class color) (min-colors 88) (background light))
                            :background "white" :foreground "#af6f00" :inverse-video t)
                           (((class color) (min-colors 88) (background dark))
                            :background "black" :foreground "#faea00" :inverse-video t)))

              ;; hl-line
              `(hl-line ((t :background ,bg-hl :extend t)))

              ;; icomplete
              `(icomplete-first-match ((t :foreground ,green :weight bold)))
              `(icomplete-selected-match ((t :background ,bg-hl)))

              ;; ido
              `(ido-first-match ((t :foreground ,green :weight bold)))
              `(ido-only-match ((t :foreground ,teal :weight bold)))
              `(ido-subdir ((t :foreground ,blue)))
              `(ido-incomplete-regexp ((t :foreground ,red1)))
              `(ido-indicator ((t :foreground ,bg :background ,red)))
              `(ido-virtual ((t :foreground ,comment)))

              ;; isearch
              `(isearch ((t :foreground ,bg :background ,magenta2 :weight bold)))
              `(isearch-fail ((t :foreground ,bg :background ,red)))
              `(isearch-group-1 ((t :foreground ,bg :background ,blue)))
              `(isearch-group-2 ((t :foreground ,bg :background ,teal)))
              `(lazy-highlight ((t :foreground ,fg :background ,dark3)))
              `(match ((t :foreground ,fg :background ,dark3)))
              `(query-replace ((t :foreground ,bg :background ,orange :weight bold)))

              ;; line-number
              `(line-number ((t :background ,bg :foreground ,fg-gutter)))
              `(line-number-current-line ((t :background ,bg :foreground ,fg-dark :weight bold)))
              `(line-number-major-tick ((t :background ,bg :foreground ,dark5)))
              `(line-number-minor-tick ((t :background ,bg :foreground ,fg-gutter)))

              ;; message
              `(message-cited-text-1 ((t :foreground ,teal)))
              `(message-cited-text-2 ((t :foreground ,green)))
              `(message-cited-text-3 ((t :foreground ,comment)))
              `(message-cited-text-4 ((t :foreground ,dark5)))
              `(message-header-cc ((t :foreground ,blue)))
              `(message-header-name ((t :foreground ,magenta)))
              `(message-header-newsgroups ((t :foreground ,teal :weight bold)))
              `(message-header-to ((t :foreground ,blue :weight bold)))
              `(message-header-other ((t :foreground ,fg-dark)))
              `(message-header-subject ((t :foreground ,fg :weight bold)))
              `(message-header-xheader ((t :foreground ,dark5)))
              `(message-mml ((t :foreground ,green)))
              `(message-separator ((t :foreground ,comment)))

              ;; mode-line / header-line
              `(mode-line ((t :foreground ,fg :background ,bg-dark1 :box ,bg-dark1)))
              '(mode-line-buffer-id ((t :weight bold)))
              '(mode-line-active ((t :inherit mode-line)))
              `(mode-line-inactive ((t :foreground ,fg-dark :background ,bg-dark :box ,bg-dark)))
              '(mode-line-emphasis ((t :slant italic)))
              `(mode-line-highlight ((t :foreground ,fg :background ,bg-hl :box ,fg)))
              '(header-line ((t :inherit mode-line)))
              '(header-line-active ((t :inherit mode-line-active)))
              '(header-line-inactive ((t :inherit mode-line-inactive)))
              '(header-line-highlight ((t :inherit mode-line-highlight)))

              ;; multiple-cursors
              `(mc/cursor-bar-face ((t :foreground ,fg :background ,bg :height 1)))
              '(mc/cursor-face ((t :inverse-video t)))
              '(mc/region-face ((t :inherit region)))

              ;; orderless
              `(orderless-match-face-0 ((t :foreground ,blue :weight bold)))
              `(orderless-match-face-1 ((t :foreground ,magenta :weight bold)))
              `(orderless-match-face-2 ((t :foreground ,teal :weight bold)))
              `(orderless-match-face-3 ((t :foreground ,orange :weight bold)))

              ;; org
              `(org-agenda-calendar-daterange ((t :foreground ,fg-dark)))
              `(org-agenda-calendar-event ((t :foreground ,fg-dark)))
              '(org-agenda-calendar-sexp ((t :inherit (bold org-agenda-calendar-event))))
              '(org-agenda-clocking ((t :inherit secondary-selection)))
              `(org-agenda-column-dateline ((t :background ,bg-dark)))
              `(org-agenda-current-time ((t :foreground ,blue)))
              `(org-agenda-date ((t :foreground ,cyan)))
              `(org-agenda-date-today ((t :foreground ,cyan :underline t)))
              `(org-agenda-date-weekend ((t :foreground ,purple)))
              `(org-agenda-date-weekend-today ((t :foreground ,purple :underline t)))
              '(org-agenda-diary ((t :inherit org-agenda-calendar-sexp)))
              '(org-agenda-dimmed-todo-face ((t :inherit shadow)))
              `(org-agenda-done ((t :foreground ,green)))
              `(org-agenda-filter-category ((t :inherit bold :foreground ,red1)))
              `(org-agenda-filter-effort ((t :inherit bold :foreground ,red1)))
              `(org-agenda-filter-regexp ((t :inherit bold :foreground ,red1)))
              `(org-agenda-filter-tags ((t :inherit bold :foreground ,red1)))
              `(org-agenda-restriction-lock ((t :background ,bg-dark :foreground ,fg-dark)))
              `(org-agenda-structure ((t :foreground ,magenta :weight bold)))
              `(org-agenda-structure-filter ((t :inherit org-agenda-structure :foreground ,yellow)))
              '(org-agenda-structure-secondary ((t :inherit font-lock-doc-face)))
              `(org-archived ((t :foreground ,comment)))
              `(org-block ((t :background ,bg-dark :extend t)))
              `(org-block-begin-line ((t :background ,bg-dark :foreground ,comment :extend t :slant italic)))
              '(org-block-end-line ((t :inherit org-block-begin-line)))
              `(org-checkbox ((t :foreground ,blue :weight bold)))
              `(org-checkbox-statistics-done ((t :foreground ,green)))
              `(org-checkbox-statistics-todo ((t :foreground ,orange)))
              '(org-clock-overlay ((t :inherit secondary-selection)))
              `(org-code ((t :foreground ,teal)))
              `(org-column ((t :background ,bg-dark)))
              `(org-column-title ((t :background ,bg-dark :weight bold :underline t)))
              `(org-date ((t :foreground ,cyan :underline t)))
              `(org-date-selected ((t :foreground ,cyan :inverse-video t)))
              `(org-dispatcher-highlight ((t :background ,bg-dark :foreground ,fg :weight bold)))
              `(org-document-info ((t :foreground ,fg-dark)))
              `(org-document-info-keyword ((t :foreground ,comment)))
              `(org-document-title ((t :foreground ,fg :weight bold)))
              `(org-done ((t :foreground ,green :weight bold)))
              `(org-drawer ((t :foreground ,comment)))
              `(org-ellipsis ((t :foreground ,comment :underline nil)))
              `(org-footnote ((t :foreground ,teal)))
              `(org-formula ((t :foreground ,orange)))
              '(org-headline-done ((t :inherit org-done)))
              '(org-headline-todo ((t :inherit org-todo)))
              `(org-hide ((t :foreground ,bg)))
              '(org-indent ((t :inherit (fixed-pitch org-hide))))
              `(org-imminent-deadline ((t :foreground ,red :weight bold)))
              `(org-latex-and-related ((t :foreground ,cyan)))
              `(org-level-1 ((t :foreground ,blue5 :weight bold)))
              `(org-level-2 ((t :foreground ,yellow :weight bold)))
              `(org-level-3 ((t :foreground ,blue :weight bold)))
              `(org-level-4 ((t :foreground ,magenta :weight bold)))
              `(org-level-5 ((t :foreground ,green :weight bold)))
              `(org-level-6 ((t :foreground ,red :weight bold)))
              `(org-level-7 ((t :foreground ,cyan :weight bold)))
              `(org-level-8 ((t :foreground ,fg-dark :weight bold)))
              `(org-link ((t :foreground ,teal :underline t)))
              '(org-list-dt ((t :inherit bold)))
              `(org-macro ((t :foreground ,magenta)))
              `(org-meta-line ((t :foreground ,comment)))
              '(org-mode-line-clock (( )))
              `(org-mode-line-clock-overrun ((t :foreground ,red1 :weight bold)))
              `(org-priority ((t :foreground ,orange)))
              `(org-property-value ((t :foreground ,fg-dark)))
              `(org-quote ((t :foreground ,fg-dark :slant italic :extent t)))
              `(org-scheduled ((t :foreground ,green)))
              `(org-scheduled-previously ((t :foreground ,orange)))
              `(org-scheduled-today ((t :foreground ,green)))
              `(org-sexp-date ((t :foreground ,cyan)))
              `(org-special-keyword ((t :foreground ,comment)))
              `(org-table ((t :foreground ,fg-dark)))
              '(org-table-header ((t :inherit (bold org-table))))
              `(org-tag ((t :foreground ,comment)))
              '(org-tag-group ((t :inherit (bold org-tag))))
              '(org-target ((t :underline t)))
              `(org-time-grid ((t :foreground ,dark5)))
              `(org-todo ((t :foreground ,orange :weight bold)))
              `(org-upcoming-deadline ((t :foreground ,red)))
              `(org-upcoming-distant-deadline ((t :foreground ,fg)))
              `(org-verbatim ((t :foreground ,green)))
              '(org-verse ((t :inherit org-quote)))
              `(org-warning ((t :foreground ,yellow :weight bold)))

              ;; pulse
              `(pulse-highlight-start-face ((t :background ,blue0 :extend t)))

              ;; regexp-builder
              `(reb-match-0 ((t :foreground ,blue :background ,bg :inverse-video t)))
              `(reb-match-1 ((t :foreground ,teal :background ,bg :inverse-video t)))
              `(reb-match-2 ((t :foreground ,magenta :background ,bg :inverse-video t)))
              `(reb-match-3 ((t :foreground ,orange :background ,bg :inverse-video t)))
              '(reb-regexp-grouping-backslash ((t :inherit font-lock-regexp-grouping-backslash)))
              '(reb-regexp-grouping-construct ((t :inherit font-lock-regexp-grouping-construct)))

              ;; ruler-mode
              '(ruler-mode-column-number ((t :inherit ruler-mode-default)))
              `(ruler-mode-comment-column ((t :inherit ruler-mode-default :foreground ,red)))
              `(ruler-mode-current-column ((t :inherit ruler-mode-default :foreground ,fg :weight bold)))
              `(ruler-mode-default ((t :background ,bg-dark :foreground ,fg-dark)))
              `(ruler-mode-fill-column ((t :inherit ruler-mode-default :foreground ,red)))
              `(ruler-mode-fringes ((t :inherit ruler-mode-default :foreground ,cyan)))
              `(ruler-mode-goal-column ((t :inherit ruler-mode-default :foreground ,blue)))
              `(ruler-mode-margins ((t :inherit ruler-mode-default :foreground ,dark3)))
              `(ruler-mode-pad ((t :inherit ruler-mode-default :background ,bg :foreground ,dark5)))
              `(ruler-mode-tab-stop ((t :inherit ruler-mode-default :foreground ,yellow)))

              ;; shell
              `(sh-heredoc ((t :foreground ,green :slant italic)))
              `(sh-quoted-exec ((t :foreground ,orange)))

              ;; show-paren-mode
              `(show-paren-match ((t :background ,terminal-black :foreground ,cyan :weight bold)))
              `(show-paren-match-expression ((t :background ,bg-hl)))
              `(show-paren-mismatch ((t :background ,bg-hl :foreground ,red :weight bold)))

              ;; speedbar
              `(speedbar-button-face ((t :foreground ,green)))
              `(speedbar-directory-face ((t :foreground ,blue :weight bold)))
              `(speedbar-file-face ((t :foreground ,fg)))
              `(speedbar-highlight-face ((t :background ,bg-hl)))
              `(speedbar-selected-face ((t :foreground ,orange :weight bold)))
              `(speedbar-separator-face ((t :background ,bg-dark :foreground ,comment)))
              `(speedbar-tag-face ((t :foreground ,teal)))

              ;; tab-bar
              `(tab-bar ((t :foreground ,fg-dark :background ,bg-dark1)))
              `(tab-bar-tab ((t :foreground ,fg :background ,bg :weight bold)))
              `(tab-bar-tab-group-current ((t :foreground ,blue :background ,bg :weight bold)))
              `(tab-bar-tab-group-inactive ((t :foreground ,dark5 :background ,bg-dark)))
              `(tab-bar-tab-highlight ((t :background ,bg-hl)))
              `(tab-bar-tab-inactive ((t :foreground ,dark5 :background ,bg-dark)))
              `(tab-bar-tab-ungrouped ((t :foreground ,comment :background ,bg-dark)))

              ;; tab-line
              `(tab-line ((t :foreground ,fg-dark :background ,bg-dark1 :height 0.95)))
              `(tab-line-close-highlight ((t :foreground ,red1)))
              `(tab-line-highlight ((t :background ,bg-hl)))
              `(tab-line-tab ((t :foreground ,fg :background ,bg :weight bold)))
              `(tab-line-tab-current ((t :foreground ,fg :background ,bg :weight bold)))
              `(tab-line-tab-inactive ((t :foreground ,dark5 :background ,bg-dark)))
              `(tab-line-tab-inactive-alternate ((t :foreground ,dark5 :background ,bg-dark)))
              `(tab-line-tab-modified ((t :foreground ,yellow)))

              ;; vertico
              `(vertico-current ((t :background ,bg-hl :weight bold)))

              ;; vundo
              `(vundo-default ((t :foreground ,dark5)))
              `(vundo-node ((t :foreground ,dark5)))
              `(vundo-stem ((t :foreground ,fg-gutter)))
              `(vundo-branch-stem ((t :foreground ,dark3)))
              `(vundo-highlight ((t :foreground ,blue :weight bold)))
              `(vundo-last-saved ((t :foreground ,green :weight bold)))
              `(vundo-saved ((t :foreground ,green)))

              ;; which-func-mode
              `(which-func ((t :foreground ,blue)))

              ;; which-key
              `(which-key-command-description-face ((t :foreground ,fg)))
              `(which-key-group-description-face ((t :foreground ,magenta)))
              `(which-key-highlighted-command-face ((t :foreground ,orange :weight bold)))
              `(which-key-key-face ((t :foreground ,blue :weight bold)))
              `(which-key-local-map-description-face ((t :foreground ,teal)))
              `(which-key-note-face ((t :foreground ,comment)))
              `(which-key-separator-face ((t :foreground ,comment)))
              `(which-key-special-key-face ((t :foreground ,red :weight bold)))
              `(which-key-docstring-face ((t :foreground ,comment :slant italic)))

              ;; whitespace-mode
              `(whitespace-big-indent ((t :background ,bg-hl :foreground ,orange)))
              `(whitespace-empty ((t :background ,red1 :extend t)))
              `(whitespace-hspace ((t  :foreground ,fg-gutter)))
              `(whitespace-indentation ((t :foreground ,fg-gutter)))
              `(whitespace-line ((t :background ,bg-hl :foreground ,red)))
              `(whitespace-newline ((t :foreground ,fg-gutter)))
              `(whitespace-space ((t :foreground ,fg-gutter)))
              `(whitespace-space-after-tab ((t :foreground ,fg-gutter)))
              `(whitespace-space-before-tab ((t :foreground ,orange)))
              `(whitespace-tab ((t :foreground ,fg-gutter)))
              `(whitespace-trailing ((t :background ,red1)))

              ;; widget
              `(widget-button ((t :inherit bold :foreground ,blue1)))
              `(widget-button-pressed ((t :inherit widget-button :foreground ,magenta)))
              '(widget-documentation ((t :inherit font-lock-doc-face)))
              `(widget-field ((t :background ,dark3 :foreground ,fg :extend nil)))
              `(widget-inactive ((t :background ,bg-dark :foreground ,fg-dark)))
              '(widget-single-line-field ((t :inherit widget-field)))

              ;; window-divider-mode
              `(window-divider ((t :foreground ,terminal-black)))
              `(window-divider-first-pixel ((t :foreground ,terminal-black)))
              `(window-divider-last-pixel ((t :foreground ,terminal-black))))
             (custom-theme-set-variables
              ',name
              `(ansi-color-names-vector [,fg-gutter ,red ,teal ,yellow ,blue ,magenta ,cyan ,fg-dark])
              '(diff-font-lock-syntax nil)
              '(frame-background-mode ',background-mode))
             ,@(unless theme-exists-p
                 (list `(provide-theme ',name))))))
    (error "No palette found for `%s'" name)))

(defun tokyonight-themes--with-colors-subr (&rest body)
  "Evaluate BODY for `tokyonight-themes-with-colors'."
  (condition-case data
      (when-let* ((theme (or (car (seq-filter
                                   (lambda (th)
                                     (string-prefix-p "tokyonight-" (symbol-name th)))
                                   custom-enabled-themes))
                             (user-error "No enabled tokyonight theme could be found")))
                  (palette-symbol (intern-soft (format "%s-palette" theme)))
                  (_ (boundp palette-symbol))
                  (palette (symbol-value palette-symbol)))
        (eval
         `(let (,@palette)
            ,body)))
    (error (message "Error in tokyonight-themes-with-colors: %s" data))))

;;;###autoload
(defmacro tokyonight-themes-with-colors (&rest body)
  "Evaluate BODY with current TokyoNight theme's palette `let' bound."
  (declare (indent 0))
  `(tokyonight-themes--with-colors-subr
    (lambda () ,@body)))

;;;; Add themes from package to path

;;;###autoload
(when load-file-name
  (let ((dir (file-name-directory load-file-name)))
    (unless (equal dir (expand-file-name "themes/" data-directory))
      (add-to-list 'custom-theme-load-path dir))))

(provide 'tokyonight-themes)
;;; tokyonight-themes.el ends here
