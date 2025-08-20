;;; tokyonight-themes.el --- TokyoNight themes. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(defgroup tokyonight-themes ()
  "TokyoNight themes."
  :group 'faces)

(defconst tokyonight-themes-faces
  '(
    ;; basic faces
    `(default ((,c :foreground ,fg :background ,bg)))
    `(bold ((,c :weight bold)))
    `(italic ((,c :slant italic)))
    `(bold-italic ((,c :inherit (bold italic))))
    `(underline ((,c :underline t)))
    `(cursor ((,c :background ,fg)))
    `(fringe ((,c :background unspecified :foreground ,fg)))
    `(menu ((,c :background ,bg-dark :foreground ,fg)))
    `(scroll-bar ((,c :background ,bg-dark :foreground ,fg-dark)))
    `(tool-bar ((,c :background ,bg-dark :foreground ,fg)))
    `(button ((,c :background unspecified :foreground ,blue1 :underline ,blue1)))
    `(link ((,c :inherit button)))
    `(link-visited ((,c :background ,bg :foreground ,purple :underline ,purple)))
    `(match ((,c :foreground ,blue :background ,bg :inverse-video t)))
    `(shadow ((,c :foreground ,fg-dark)))
    `(minibuffer-prompt ((,c :foreground ,purple :background unspecified)))
    `(region ((,c :background ,fg-gutter :foreground ,fg :extend t)))
    `(secondary-selection ((,c :background ,bg-hl :foreground unspecified)))
    `(trailing-whitespace ((,c :foreground ,fg :background ,red1)))
    `(border ((,c :background ,dark3 :foreground ,fg)))
    `(vertical-border ((,c :foreground ,dark3)))
    `(child-frame-border ((,c :background ,dark3)))
    `(tooltip ((,c :background ,bg-dark :foreground ,fg)))
    `(highlight ((,c :background ,bg-hl :foreground ,fg)))
    `(error ((,c :inherit bold :foreground ,red1)))
    `(warning ((,c :inherit bold :foreground ,yellow)))
    `(success ((,c :inherit bold :foreground ,cyan)))
    `(help-argument-name ((,c :inherit italic :foreground ,yellow)))
    `(help-key-binding ((,c :inherit bold :foreground ,blue)))

    ;; font-lock
    `(font-lock-bracket-face ((,c :foreground ,fg)))
    `(font-lock-builtin-face ((,c :foreground ,purple)))
    `(font-lock-comment-face ((,c :inherit italic :foreground ,comment)))
    `(font-lock-comment-delimiter-face ((,c :inherit font-lock-comment-face)))
    `(font-lock-constant-face ((,c :foreground ,orange)))
    `(font-lock-delimiter-face ((,c :foreground ,fg)))
    `(font-lock-doc-face ((,c :foreground ,green2)))
    `(font-lock-doc-markup-face ((,c :foreground ,magenta)))
    `(font-lock-function-name-face ((,c :foreground ,blue)))
    `(font-lock-keyword-face ((,c :foreground ,magenta)))
    `(font-lock-negation-char-face ((,c :inherit error)))
    `(font-lock-number-face ((,c :foreground ,orange)))
    `(font-lock-operator-face ((,c :foreground ,blue5)))
    `(font-lock-preprocessor-face ((,c :foreground ,cyan)))
    `(font-lock-property-name-face ((,c :foreground ,yellow)))
    `(font-lock-punctuation-face ((,c :foreground ,fg)))
    `(font-lock-regexp-grouping-backslash ((,c :foreground ,yellow)))
    `(font-lock-regexp-grouping-construct ((,c :foreground ,magenta)))
    `(font-lock-string-face ((,c :foreground ,green)))
    `(font-lock-type-face ((,c :foreground ,blue1)))
    `(font-lock-variable-name-face ((,c :foreground ,yellow)))
    `(font-lock-warning-face ((,c :foreground ,yellow)))

    ;; ansi-color
    `(ansi-color-black ((,c :background "black" :foreground "black")))
    `(ansi-color-blue ((,c :background ,blue :foreground ,blue)))
    `(ansi-color-bold ((,c :inherit bold)))
    `(ansi-color-cyan ((,c :background ,cyan :foreground ,cyan)))
    `(ansi-color-green ((,c :background ,green :foreground ,green)))
    `(ansi-color-magenta ((,c :background ,purple :foreground ,purple)))
    `(ansi-color-red ((,c :background ,red1 :foreground ,red1)))
    `(ansi-color-white ((,c :background "gray65" :foreground "gray65")))
    `(ansi-color-yellow ((,c :background ,orange :foreground ,orange)))
    `(ansi-color-bright-black ((,c :background "gray35" :foreground "gray35")))
    `(ansi-color-bright-blue ((,c :background ,blue1 :foreground ,blue1)))
    `(ansi-color-bright-cyan ((,c :background ,blue6 :foreground ,blue6)))
    `(ansi-color-bright-green ((,c :background ,green1 :foreground ,green1)))
    `(ansi-color-bright-magenta ((,c :background ,magenta :foreground ,magenta)))
    `(ansi-color-bright-red ((,c :background ,red :foreground ,red)))
    `(ansi-color-bright-white ((,c :background "white" :foreground "white")))
    `(ansi-color-bright-yellow ((,c :background ,yellow :foreground ,yellow)))

    ;; ace-window
    `(aw-background-face ((,c :foreground "gray50")))
    `(aw-key-face ((,c :inherit bold :foreground ,blue)))
    `(aw-leading-char-face ((,c :inherit bold :height 1.5 :foreground ,red)))
    `(aw-minibuffer-leading-char-face ((,c :inherit aw-key-face)))
    `(aw-mode-line-face ((,c :inherit bold)))

    ;; avy
    `(avy-background-face ((,c :background ,bg-dark :foreground ,fg-dark :extend t)))
    `(avy-goto-char-timer-face ((,c :inherit bold :background ,bg-hl)))
    `(avy-lead-face ((,c :inherit bold :background ,blue :foreground ,bg)))
    `(avy-lead-face-0 ((,c :inherit bold :background ,magenta :foreground ,bg)))
    `(avy-lead-face-1 ((,c :background ,dark3)))
    `(avy-lead-face-2 ((,c :inherit bold :background ,yellow :foreground ,bg)))

    ;; bookmark
    `(bookmark-face ((,c :inherit success)))
    `(bookmark-menu-bookmark ((,c :inherit bold)))

    ;; calendar and diary
    `(calendar-month-header ((,c :inherit bold)))
    `(calendar-today ((,c :inherit bold :underline t)))
    `(calendar-weekday-header ((,c :foreground ,cyan)))
    `(calendar-weekend-header ((,c :foreground ,red1)))
    `(diary ((,c :foreground ,cyan)))
    `(diary-anniversary ((,c :foreground ,red1)))
    `(diary-time ((,c :foreground ,cyan)))
    `(holiday ((,c :foreground ,red1)))

    ;; compilation
    `(compilation-info ((,c :inherit bold :foreground ,cyan)))
    `(compilation-warning ((,c :inherit bold :foreground ,yellow)))
    `(compilation-error ((,c :inherit bold :foreground ,red1)))
    `(compilation-line-number ((,c :inherit shadow)))
    `(compilation-column-number ((,c :inherit compilation-line-number)))
    `(compilation-mode-line-exit ((,c :inherit bold)))
    `(compilation-mode-line-fail ((,c :inherit bold :foreground ,red1)))
    `(compilation-mode-line-run ((,c :inherit bold :foreground ,yellow)))

    ;; completions
    `(completions-annotations ((,c :foreground ,green2 :background unspecified :slant italic)))
    `(completions-common-part ((,c :foreground ,blue1 :background unspecified)))
    `(completions-first-difference ((,c :foreground ,purple :background unspecified :weight bold)))
    `(completions-highlight ((,c :background ,bg-hl :weight bold)))

    ;; corfu
    `(corfu-default ((,c :foreground ,fg :background ,bg-dark)))
    `(corfu-current ((,c :foreground ,fg :background ,bg-hl :weight bold)))
    `(corfu-bar ((,c :background ,fg-dark)))
    `(corfu-border ((,c :background ,dark3)))

    ;; custom (M-x customize)
    `(custom-button ((,c :background ,bg-dark :foreground ,fg-dark :box(:line-width 1 :color ,fg-dark :style released-button))))
    `(custom-button-mouse ((,c :inherit (highlight custom-button))))
    `(custom-button-pressed ((,c :inherit (secondary-selection custom-button))))
    `(custom-changed ((,c :background ,orange)))
    `(custom-comment ((,c :inherit shadow)))
    `(custom-comment-tag ((,c :inherit (bold shadow))))
    `(custom-invalid ((,c :inherit error :strike-through t)))
    `(custom-modified ((,c :inherit custom-changed)))
    `(custom-rogue ((,c :inherit custom-invalid)))
    `(custom-set ((,c :inherit success)))
    `(custom-state ((,c :foreground ,orange)))
    `(custom-themed ((,c :inherit custom-changed)))
    `(custom-variable-obsolete ((,c :inherit shadow)))
    `(custom-face-tag ((,c :inherit bold :foreground ,blue)))
    `(custom-group-tag ((,c :inherit bold :foreground ,magenta)))
    `(custom-group-tag-1 ((,c :inherit bold :foreground ,orange)))
    `(custom-variable-tag ((,c :inherit bold :foreground ,blue2)))

    ;; diff
    `(diff-added ((,c :foreground ,green :background ,bg-hl)))
    `(diff-changed ((,c :foreground ,yellow :background ,bg-hl)))
    `(diff-changed-unspecified ((,c :inherit diff-changed)))
    `(diff-removed ((,c :foreground ,red :background ,bg-hl)))
    `(diff-indicator-added ((,c :inherit diff-added)))
    `(diff-indicator-changed ((,c :inherit diff-changed)))
    `(diff-indicator-removed ((,c :inherit diff-removed)))
    `(diff-refine-added ((,c :inherit diff-added :inverse-video t)))
    `(diff-refine-changed ((,c :inherit diff-changed :inverse-video t)))
    `(diff-refine-removed ((,c :inherit diff-removed :inverse-video t)))
    `(diff-context (()))
    `(diff-error ((,c :inherit error)))
    `(diff-file-header ((,c :inherit bold)))
    `(diff-function ((,c :background ,dark3)))
    `(diff-header (()))
    `(diff-hunk-header ((,c :inherit bold :background ,dark3)))
    `(diff-index ((,c :slant italic)))
    `(diff-nonexistent ((,c :inherit bold)))

    ;; diff-hl
    `(diff-hl-change ((,c :foreground ,bg :background ,yellow)))
    `(diff-hl-delete ((,c :foreground ,bg :background ,red)))
    `(diff-hl-insert ((,c :foreground ,bg :background ,green)))
    `(diff-hl-reverted-hunk-highlight ((,c :foreground ,bg :background ,fg)))

    ;; dired
    `(dired-broken-symlink ((,c :inherit button :foreground ,red1)))
    `(dired-directory ((,c :foreground ,blue)))
    `(dired-flagged ((,c :inherit bold :foreground ,cyan :inverse-video t)))
    `(dired-header ((,c :inherit bold)))
    `(dired-ignored ((,c :inherit shadow)))
    `(dired-mark ((,c :inherit bold)))
    `(dired-marked ((,c :inherit bold :foreground ,cyan :inverse-video t)))
    `(dired-perm-write ((,c :inherit shadow)))
    `(dired-symlink ((,c :foreground ,cyan :background ,bg :underline ,cyan)))
    `(dired-warning ((,c :inherit warning)))

    ;; elfeed
    `(elfeed-log-date-face ((,c :inherit elfeed-search-date-face)))
    `(elfeed-log-debug-level-face ((,c :inherit elfeed-search-filter-face)))
    `(elfeed-log-error-level-face ((,c :inherit error)))
    `(elfeed-log-info-level-face ((,c :inherit success)))
    `(elfeed-log-warn-level-face ((,c :inherit warning)))
    `(elfeed-search-date-face ((,c :foreground ,cyan)))
    `(elfeed-search-feed-face ((,c :foreground ,purple)))
    `(elfeed-search-filter-face ((,c :inherit bold)))
    `(elfeed-search-last-update-face ((,c :inherit bold :foreground ,cyan)))
    `(elfeed-search-tag-face ((,c :foreground ,blue)))
    `(elfeed-search-title-face ((,c :foreground ,fg-dark)))
    `(elfeed-search-unread-count-face (( )))
    `(elfeed-search-unread-title-face ((,c :inherit bold :foreground ,fg)))

    ;; eshell
    `(eshell-prompt ((,c :foreground ,purple :weight bold)))
    `(eshell-ls-archive ((,c :foreground ,red1)))
    `(eshell-ls-backup ((,c :inherit font-lock-comment-face)))
    `(eshell-ls-clutter ((,c :inherit font-lock-comment-face)))
    `(eshell-ls-directory ((,c :foreground ,blue)))
    `(eshell-ls-executable ((,c :foreground ,green)))
    `(eshell-ls-missing ((,c :inherit font-lock-warning-face)))
    `(eshell-ls-product ((,c :inherit font-lock-doc-face)))
    `(eshell-ls-special ((,c :foreground ,yellow :weight bold)))
    `(eshell-ls-symlink ((,c :foreground ,cyan :weight bold)))
    `(eshell-ls-unreadable ((,c :foreground ,fg)))

    ;; flymake
    `(flymake-error ((,c :underline (:style wave :color ,red))))
    `(flymake-warning ((,c :underline (:style wave :color ,orange))))
    `(flymake-note ((,c :underline (:style wave :color ,cyan))))

    ;; flyspell
    `(flyspell-duplicate ((,c :underline (:style wave :color ,orange))))
    `(flyspell-incorrect ((,c :underline (:style wave :color ,red))))

    ;; hi-lock (M-x highlight-regexp)
    `(hi-aquamarine ((((class color) (min-colors 88) (background light))
                      :background "white" :foreground "#227f9f" :inverse-video t)
                     (((class color) (min-colors 88) (background dark))
                      :background "black" :foreground "#66cbdc" :inverse-video t)))
    `(hi-black-b ((,c :inverse-video t)))
    `(hi-black-hb ((,c :background ,bg :foreground ,fg-dark :inverse-video t)))
    `(hi-blue ((((class color) (min-colors 88) (background light))
                :background "white" :foreground "#3366dd" :inverse-video t)
               (((class color) (min-colors 88) (background dark))
                :background "black" :foreground "#aaccff" :inverse-video t)))
    `(hi-blue-b ((,c :inherit (bold hi-blue))))
    `(hi-green ((((class color) (min-colors 88) (background light))
                 :background "white" :foreground "#008a00" :inverse-video t)
                (((class color) (min-colors 88) (background dark))
                 :background "black" :foreground "#66dd66" :inverse-video t)))
    `(hi-green-b ((,c :inherit (bold hi-green))))
    `(hi-pink ((((class color) (min-colors 88) (background light))
                :background "white" :foreground "#bd30aa" :inverse-video t)
               (((class color) (min-colors 88) (background dark))
                :background "black" :foreground "#ff88ee" :inverse-video t)))
    `(hi-red-b ((((class color) (min-colors 88) (background light))
                 :background "white" :foreground "#dd0000" :inverse-video t)
                (((class color) (min-colors 88) (background dark))
                 :background "black" :foreground "#f06666" :inverse-video t)))
    `(hi-salmon ((((class color) (min-colors 88) (background light))
                  :background "white" :foreground "#af4f6f" :inverse-video t)
                 (((class color) (min-colors 88) (background dark))
                  :background "black" :foreground "#e08a50" :inverse-video t)))
    `(hi-yellow ((((class color) (min-colors 88) (background light))
                  :background "white" :foreground "#af6f00" :inverse-video t)
                 (((class color) (min-colors 88) (background dark))
                  :background "black" :foreground "#faea00" :inverse-video t)))

    ;; hl-line
    `(hl-line ((,c :background ,bg-hl :extend t)))

    ;; icomplete
    `(icomplete-first-match ((,c :foreground ,blue1 :weight bold)))
    `(icomplete-selected-match ((,c :background ,bg-hl :weight bold)))

    ;; ido
    `(ido-first-match ((,c :foreground ,blue1 :weight bold)))
    `(ido-incomplete-regexp ((,c :inherit error :weight bold)))
    `(ido-indicator ((,c :inherit bold)))
    `(ido-only-match ((,c :inherit ido-first-match)))
    `(ido-subdir ((,c :foreground ,blue1)))
    `(ido-virtual ((,c :foreground ,purple)))

    ;; isearch
    `(isearch ((,c :foreground ,yellow :background ,bg :inverse-video t)))
    `(isearch-fail ((,c :foreground ,red :background ,bg :inverse-video t)))
    `(isearch-group-1 ((,c :foreground ,blue1 :background ,bg :inverse-video t)))
    `(isearch-group-2 ((,c :foreground ,green1 :background ,bg :inverse-video t)))
    `(lazy-highlight ((,c :foreground ,cyan :background ,bg :inverse-video t)))

    ;; line-number
    `(line-number ((,c :inherit default :foreground ,fg-dark)))
    `(line-number-current-line ((,c :inherit (bold line-number) :foreground ,fg)))
    `(line-number-major-tick ((,c :inherit line-number :foreground ,red)))
    `(line-number-minor-tick ((,c :inherit line-number :foreground ,fg-dark)))

    ;; message
    `(message-cited-text-1 ((,c :foreground ,blue)))
    `(message-cited-text-2 ((,c :foreground ,yellow)))
    `(message-cited-text-3 ((,c :foreground ,cyan)))
    `(message-cited-text-4 ((,c :foreground ,red)))
    `(message-header-name ((,c :inherit bold)))
    `(message-header-newsgroups ((,c :inherit message-header-other)))
    `(message-header-to ((,c :inherit bold :foreground ,magenta)))
    `(message-header-cc ((,c :foreground ,magenta)))
    `(message-header-subject ((,c :inherit bold :foreground ,purple)))
    `(message-header-xheader ((,c :inherit message-header-other)))
    `(message-header-other ((,c :foreground ,purple)))
    `(message-mml ((,c :foreground ,blue1)))
    `(message-separator ((,c :background ,dark3)))

    ;; mode-line / header-line
    `(mode-line ((,c :foreground ,fg :background ,bg-dark1 :box ,bg-dark1)))
    `(mode-line-buffer-id ((,c :inherit bold)))
    `(mode-line-active ((,c :inherit mode-line)))
    `(mode-line-inactive ((,c :foreground ,fg-dark :background ,bg-dark :box ,bg-dark)))
    `(mode-line-emphasis ((,c :inherit bold :foreground ,blue)))
    `(mode-line-highlight ((,c :foreground ,fg :background ,bg-hl :box ,fg)))
    `(header-line ((,c :inherit mode-line)))
    `(header-line-active ((,c :inherit mode-line-active)))
    `(header-line-inactive ((,c :inherit mode-line-inactive)))
    `(header-line-highlight ((,c :inherit mode-line-highlight)))

    ;; multiple-cursors
    `(mc/cursor-bar-face ((,c :foreground ,fg :background ,bg :height 1)))
    `(mc/cursor-face ((,c :inverse-video t)))
    `(mc/region-face ((,c :inherit region)))

    ;; orderless
    `(orderless-match-face-0 ((,c :foreground ,blue)))
    `(orderless-match-face-1 ((,c :foreground ,purple)))
    `(orderless-match-face-2 ((,c :foreground ,teal)))
    `(orderless-match-face-3 ((,c :foreground ,red1)))

    ;; org
    `(org-agenda-calendar-daterange ((,c :foreground ,fg-dark)))
    `(org-agenda-calendar-event ((,c :foreground ,fg-dark)))
    `(org-agenda-calendar-sexp ((,c :inherit (bold org-agenda-calendar-event))))
    `(org-agenda-clocking ((,c :inherit bold :background ,yellow :foreground ,fg)))
    `(org-agenda-column-dateline ((,c :background ,bg-dark)))
    `(org-agenda-current-time ((,c :foreground ,fg)))
    `(org-agenda-date ((,c :foreground ,cyan)))
    `(org-agenda-date-today ((,c :inherit org-agenda-date :underline t)))
    `(org-agenda-date-weekend ((,c :inherit org-agenda-date :foreground ,magenta)))
    `(org-agenda-date-weekend-today ((,c :inherit org-agenda-date-today :foreground ,magenta)))
    `(org-agenda-diary ((,c :inherit org-agenda-calendar-sexp)))
    `(org-agenda-dimmed-todo-face ((,c :inherit shadow)))
    `(org-agenda-done ((,c :inherit org-done)))
    `(org-agenda-filter-category ((,c :inherit bold :foreground ,red1)))
    `(org-agenda-filter-effort ((,c :inherit bold :foreground ,red1)))
    `(org-agenda-filter-regexp ((,c :inherit bold :foreground ,red1)))
    `(org-agenda-filter-tags ((,c :inherit bold :foreground ,red1)))
    `(org-agenda-restriction-lock ((,c :background ,bg-dark :foreground ,fg-dark)))
    `(org-agenda-structure ((,c :foreground ,fg-dark)))
    `(org-agenda-structure-filter ((,c :inherit org-agenda-structure :foreground ,yellow)))
    `(org-agenda-structure-secondary ((,c :inherit font-lock-doc-face)))
    `(org-archived ((,c :background ,bg-dark :foreground ,fg)))
    `(org-block ((,c :background ,bg-dark :extend t)))
    `(org-block-begin-line ((,c :background ,bg-dark :foreground ,fg-dark :extend t)))
    `(org-block-end-line ((,c :inherit org-block-begin-line)))
    `(org-checkbox ((,c :foreground ,yellow)))
    `(org-checkbox-statistics-done ((,c :inherit org-done)))
    `(org-checkbox-statistics-todo ((,c :inherit org-todo)))
    `(org-clock-overlay ((,c :inherit secondary-selection)))
    `(org-code ((,c :background unspecified :foreground ,cyan)))
    `(org-column ((,c :inherit default :background ,bg-dark)))
    `(org-column-title ((,c :inherit (bold default) :underline t :background ,bg-dark)))
    `(org-date ((,c :foreground ,cyan)))
    `(org-date-selected ((,c :foreground ,cyan :inverse-video t)))
    `(org-dispatcher-highlight ((,c :inherit bold :background ,bg-dark :foreground ,fg)))
    `(org-document-info ((,c :foreground ,fg-dark)))
    `(org-document-info-keyword ((,c :foreground ,fg-dark)))
    `(org-document-title ((,c :foreground ,cyan)))
    `(org-done ((,c :foreground ,green)))
    `(org-drawer ((,c :foreground ,fg-dark)))
    `(org-ellipsis (( ))) ; inherits from the heading's color
    `(org-footnote ((,c :inherit link)))
    `(org-formula ((,c :foreground ,magenta)))
    `(org-headline-done ((,c :inherit org-done)))
    `(org-headline-todo ((,c :inherit org-todo)))
    `(org-hide ((,c :foreground ,bg)))
    `(org-indent ((,c :inherit (fixed-pitch org-hide))))
    `(org-imminent-deadline ((,c :inherit bold :foreground ,red)))
    `(org-latex-and-related ((,c :foreground ,cyan)))
    `(org-level-1 ((,c :foreground ,fg)))
    `(org-level-2 ((,c :foreground ,yellow)))
    `(org-level-3 ((,c :foreground ,blue)))
    `(org-level-4 ((,c :foreground ,magenta)))
    `(org-level-5 ((,c :foreground ,green)))
    `(org-level-6 ((,c :foreground ,red)))
    `(org-level-7 ((,c :foreground ,cyan)))
    `(org-level-8 ((,c :foreground ,fg-dark)))
    `(org-link ((,c :inherit link)))
    `(org-list-dt ((,c :inherit bold)))
    `(org-macro ((,c :foreground ,magenta)))
    `(org-meta-line ((,c :foreground ,fg-dark)))
    `(org-mode-line-clock (( )))
    `(org-mode-line-clock-overrun ((,c :inherit bold :foreground ,red1)))
    `(org-priority ((,c :foreground ,magenta)))
    `(org-property-value ((,c :foreground ,fg-dark)))
    `(org-quote ((,c :inherit org-block)))
    `(org-scheduled ((,c :foreground ,orange)))
    `(org-scheduled-previously ((,c :inherit (bold org-scheduled-today))))
    `(org-scheduled-today ((,c :foreground ,yellow)))
    `(org-sexp-date ((,c :foreground ,cyan)))
    `(org-special-keyword ((,c :inherit org-drawer)))
    `(org-table ((,c :foreground ,fg-dark)))
    `(org-table-header ((,c :inherit (bold org-table))))
    `(org-tag ((,c :foreground ,magenta)))
    `(org-tag-group ((,c :inherit (bold org-tag))))
    `(org-target ((,c :underline t)))
    `(org-time-grid ((,c :foreground ,fg-dark)))
    `(org-todo ((,c :foreground ,red1)))
    `(org-upcoming-deadline ((,c :foreground ,red1)))
    `(org-upcoming-distant-deadline ((,c :foreground ,fg)))
    `(org-verbatim ((,c :foreground ,magenta)))
    `(org-verse ((,c :inherit org-block)))
    `(org-warning ((,c :inherit warning)))

    ;; regexp-builder
    `(reb-match-0 ((,c :foreground ,blue1 :background ,bg :inverse-video t)))
    `(reb-match-1 ((,c :foreground ,green1 :background ,bg :inverse-video t)))
    `(reb-match-2 ((,c :foreground ,red1 :background ,bg :inverse-video t)))
    `(reb-match-3 ((,c :foreground ,magenta2 :background ,bg :inverse-video t)))
    `(reb-regexp-grouping-backslash ((,c :inherit font-lock-regexp-grouping-backslash)))
    `(reb-regexp-grouping-construct ((,c :inherit font-lock-regexp-grouping-construct)))

    ;; ruler-mode
    `(ruler-mode-column-number ((,c :inherit ruler-mode-default)))
    `(ruler-mode-comment-column ((,c :inherit ruler-mode-default :foreground ,red)))
    `(ruler-mode-current-column ((,c :inherit ruler-mode-default :background ,bg-dark :foreground ,fg)))
    `(ruler-mode-default ((,c :inherit default :background ,bg-dark :foreground ,fg-dark)))
    `(ruler-mode-fill-column ((,c :inherit ruler-mode-default :foreground ,green)))
    `(ruler-mode-fringes ((,c :inherit ruler-mode-default :foreground ,cyan)))
    `(ruler-mode-goal-column ((,c :inherit ruler-mode-default :foreground ,blue)))
    `(ruler-mode-margins ((,c :inherit ruler-mode-default :foreground ,dark3)))
    `(ruler-mode-pad ((,c :inherit ruler-mode-default :background ,bg :foreground ,dark5)))
    `(ruler-mode-tab-stop ((,c :inherit ruler-mode-default :foreground ,yellow)))

    ;; shell
    `(sh-heredoc ((,c :inherit font-lock-string-face)))
    `(sh-quoted-exec ((,c :inherit font-lock-builtin-face)))

    ;; show-paren-mode
    `(show-paren-match ((,c :background ,blue0 :foreground ,fg)))
    `(show-paren-match-expression ((,c :background ,magenta2 :foreground ,fg)))
    `(show-paren-mismatch ((,c :background ,red1 :foreground ,fg)))

    ;; speedbar
    `(speedbar-button-face ((,c :inherit button)))
    `(speedbar-directory-face ((,c :inherit bold :foreground ,blue2)))
    `(speedbar-file-face ((,c :foreground ,fg)))
    `(speedbar-highlight-face ((,c :inherit highlight)))
    `(speedbar-selected-face ((,c :foreground ,cyan :weight bold :inverse-video t)))
    `(speedbar-separator-face ((,c :background ,dark3 :foreground ,fg)))
    `(speedbar-tag-face ((,c :foreground ,magenta2)))

    ;; tab-bar
    `(tab-bar ((,c :background ,bg-dark)))
    `(tab-bar-tab ((,c :inherit bold :foreground ,fg :background ,bg)))
    `(tab-bar-tab-group-current ((,c :inherit bold :foreground ,fg :background ,bg)))
    `(tab-bar-tab-group-inactive ((,c :foreground ,fg-dark :background ,bg-dark)))
    `(tab-bar-tab-highlight ((,c :inherit highlight)))
    `(tab-bar-tab-inactive ((,c :background ,terminal-black)))
    `(tab-bar-tab-ungrouped ((,c :inherit tab-bar-tab-inactive)))

    ;; tab-line
    `(tab-line ((,c :background ,bg-dark :height 0.95)))
    `(tab-line-close-highlight ((,c :foreground ,red1)))
    `(tab-line-highlight ((,c :inherit highlight)))
    `(tab-line-tab (( )))
    `(tab-line-tab-current ((,c :inherit bold :background ,bg)))
    `(tab-line-tab-inactive ((,c :background ,terminal-black)))
    `(tab-line-tab-inactive-alternate ((,c :inherit tab-line-tab-inactive)))
    `(tab-line-tab-modified ((,c :foreground ,orange)))

    ;; vertico
    `(vertico-current ((,c :background ,bg-hl :weight bold)))

    ;; vundo
    `(vundo-default ((,c :inherit shadow)))
    `(vundo-highlight ((,c :inherit (bold vundo-node) :foreground ,red)))
    `(vundo-last-saved ((,c :inherit (bold vundo-node) :foreground ,blue)))
    `(vundo-saved ((,c :inherit vundo-mode :foreground ,blue5)))

    ;; which-func-mode
    `(which-func ((,c :inherit bold :foreground ,blue)))

    ;; which-key
    `(which-key-command-description-face ((,c :foreground ,fg)))
    `(which-key-group-description-face ((,c :foreground ,purple)))
    `(which-key-highlighted-command-face ((,c :inherit warning :underline t)))
    `(which-key-key-face ((,c :inherit bold :foreground ,blue)))
    `(which-key-local-map-description-face ((,c :foreground ,fg)))
    `(which-key-note-face ((,c :inherit shadow)))
    `(which-key-separator-face ((,c :inherit shadow)))
    `(which-key-special-key-face ((,c :inherit error)))

    ;; whitespace-mode
    `(whitespace-big-indent ((,c :background ,red1)))
    `(whitespace-empty ((,c :background unspecified)))
    `(whitespace-hspace ((,c :background unspecified :foreground ,fg-dark)))
    `(whitespace-indentation ((,c :background unspecified :foreground ,fg-dark)))
    `(whitespace-line ((,c :background unspecified :foreground ,orange)))
    `(whitespace-newline ((,c :background unspecified :foreground ,fg-dark)))
    `(whitespace-space ((,c :background unspecified :foreground ,fg-dark)))
    `(whitespace-space-after-tab ((,c :inherit warning :background unspecified)))
    `(whitespace-space-before-tab ((,c :inherit warning :background unspecified)))
    `(whitespace-tab ((,c :background unspecified :foreground ,fg-dark)))
    `(whitespace-trailing ((,c :background ,red1)))

    ;; widget
    `(widget-button ((,c :inherit bold :foreground ,blue1)))
    `(widget-button-pressed ((,c :inherit widget-button :foreground ,magenta)))
    `(widget-documentation ((,c :inherit font-lock-doc-face)))
    `(widget-field ((,c :background ,dark3 :foreground ,fg :extend nil)))
    `(widget-inactive ((,c :background ,bg-dark :foreground ,fg-dark)))
    `(widget-single-line-field ((,c :inherit widget-field)))

    ;; window-divider-mode
    `(window-divider ((,c :foreground ,fg-dark)))
    `(window-divider-first-pixel ((,c :foreground ,dark3)))
    `(window-divider-last-pixel ((,c :foreground ,dark3)))
    )
  "Face specs for use with `tokyonight-themes-theme'.")

(defconst tokyonight-themes-custom-variables
  '(
    ;;;; ansi-colors
    `(ansi-color-names-vector [,bg ,red ,green ,yellow ,blue ,magenta ,cyan ,fg])
  )
  "Custom variables for `tokyonight-themes-theme'.")

;;; Theme macros

;;;; Instantiate a tokyonight theme

;;;###autoload
(defmacro tokyonight-themes-theme (name palette &optional overrides)
  "Bind NAME's color PALETTE. Optional OVERRIDES are appended to PALETTE."
  (declare (indent 0))
  (let* ((palette-v (symbol-value palette))
         (overrides-v (symbol-value overrides))
         (colors (mapcar #'car palette-v)))
    `(let* ((c '((class color) (min-colors 256)))
            ,@(mapcar (lambda (color)
                        (list color
                              (or (alist-get color overrides-v)
                                  (alist-get color palette-v))))
                      colors))
       (ignore c ,@colors)
       (custom-theme-set-faces ',name ,@tokyonight-themes-faces)
       (custom-theme-set-variables ',name ,@tokyonight-themes-custom-variables))))

;;;; Use theme colors

(defmacro tokyonight-themes-with-colors (&rest body)
  "Evaluate BODY with colors from current palette bound."
  (declare (indent 0))
  (let* ((theme (or (car (seq-filter
                          (lambda (th)
                            (string-prefix-p "tokyonight-" (symbol-name th)))
                          custom-enabled-themes))
                    (user-error "No enabled tokyonight theme could be found")))
         (palette-v (symbol-value (intern (format "%s-palette" theme))))
         (overrides-v (symbol-value (intern (format "%s-palette-overrides" theme))))
         (colors (mapcar #'car palette-v)))
    `(let* ((c '((class color) (min-colors 256)))
            ,@(mapcar (lambda (color)
                        (list color
                              (or (alist-get color overrides-v)
                                  (alist-get color palette-v))))
                      colors))
       (ignore c ,@colors)
       ,@body)))

;;;; Add themes from package to path

;;;###autoload
(when load-file-name
  (let ((dir (file-name-directory load-file-name)))
    (unless (equal dir (expand-file-name "themes/" data-directory))
      (add-to-list 'custom-theme-load-path dir))))

(provide 'tokyonight-themes)
;;; tokyonight-themes.el ends here
