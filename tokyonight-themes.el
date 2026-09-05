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
              `(fringe ((t :background unspecified :foreground ,fg)))
              `(menu ((t :background ,bg-dark :foreground ,fg)))
              `(scroll-bar ((t :background ,bg-dark :foreground ,fg-dark)))
              `(tool-bar ((t :background ,bg-dark :foreground ,fg)))
              `(button ((t :background unspecified :foreground ,blue1 :underline ,blue1)))
              `(link ((t :background unspecified :foreground ,blue1 :underline ,blue1)))
              `(link-visited ((t :background ,bg :foreground ,purple :underline ,purple)))
              `(match ((t :background ,bg :foreground ,blue :inverse-video t)))
              `(shadow ((t :foreground ,fg-dark)))
              `(minibuffer-prompt ((t :foreground ,purple :background unspecified)))
              `(region ((t :background ,terminal-black :foreground ,fg :extend t)))
              `(secondary-selection ((t :background ,bg-hl :foreground unspecified)))
              `(trailing-whitespace ((t :foreground ,fg :background ,red1)))
              `(border ((t :background ,dark3 :foreground ,fg)))
              `(vertical-border ((t :foreground ,dark3)))
              `(child-frame-border ((t :background ,dark3)))
              `(tooltip ((t :background ,bg-dark :foreground ,fg)))
              `(highlight ((t :background ,bg-hl :foreground ,fg)))
              `(error ((t :inherit bold :foreground ,red1)))
              `(warning ((t :inherit bold :foreground ,yellow)))
              `(success ((t :inherit bold :foreground ,cyan)))
              `(help-argument-name ((t :inherit italic :foreground ,yellow)))
              `(help-key-binding ((t :inherit bold :foreground ,blue)))

              ;; font-lock
              `(font-lock-bracket-face ((t :foreground ,fg)))
              `(font-lock-builtin-face ((t :foreground ,purple)))
              `(font-lock-comment-face ((t :inherit italic :foreground ,comment)))
              '(font-lock-comment-delimiter-face ((t :inherit font-lock-comment-face)))
              `(font-lock-constant-face ((t :foreground ,orange)))
              `(font-lock-delimiter-face ((t :foreground ,fg)))
              `(font-lock-doc-face ((t :foreground ,green2)))
              `(font-lock-doc-markup-face ((t :foreground ,magenta)))
              `(font-lock-function-name-face ((t :foreground ,blue)))
              `(font-lock-keyword-face ((t :foreground ,magenta)))
              '(font-lock-negation-char-face ((t :inherit error)))
              `(font-lock-number-face ((t :foreground ,orange)))
              `(font-lock-operator-face ((t :foreground ,blue5)))
              `(font-lock-preprocessor-face ((t :foreground ,cyan)))
              `(font-lock-property-name-face ((t :foreground ,yellow)))
              `(font-lock-punctuation-face ((t :foreground ,fg)))
              `(font-lock-regexp-grouping-backslash ((t :foreground ,yellow)))
              `(font-lock-regexp-grouping-construct ((t :foreground ,magenta)))
              `(font-lock-string-face ((t :foreground ,green)))
              `(font-lock-type-face ((t :foreground ,blue1)))
              `(font-lock-variable-name-face ((t :foreground ,yellow)))
              `(font-lock-warning-face ((t :foreground ,yellow)))

              ;; ansi-color
              `(ansi-color-black ((t :background "black" :foreground "black")))
              `(ansi-color-blue ((t :background ,blue :foreground ,blue)))
              '(ansi-color-bold ((t :inherit bold)))
              `(ansi-color-cyan ((t :background ,cyan :foreground ,cyan)))
              `(ansi-color-green ((t :background ,green :foreground ,green)))
              `(ansi-color-magenta ((t :background ,purple :foreground ,purple)))
              `(ansi-color-red ((t :background ,red1 :foreground ,red1)))
              `(ansi-color-white ((t :background "gray65" :foreground "gray65")))
              `(ansi-color-yellow ((t :background ,orange :foreground ,orange)))
              `(ansi-color-bright-black ((t :background "gray35" :foreground "gray35")))
              `(ansi-color-bright-blue ((t :background ,blue1 :foreground ,blue1)))
              `(ansi-color-bright-cyan ((t :background ,blue6 :foreground ,blue6)))
              `(ansi-color-bright-green ((t :background ,green1 :foreground ,green1)))
              `(ansi-color-bright-magenta ((t :background ,magenta :foreground ,magenta)))
              `(ansi-color-bright-red ((t :background ,red :foreground ,red)))
              `(ansi-color-bright-white ((t :background "white" :foreground "white")))
              `(ansi-color-bright-yellow ((t :background ,yellow :foreground ,yellow)))

              ;; ace-window
              `(aw-background-face ((t :foreground "gray50")))
              `(aw-key-face ((t :inherit bold :foreground ,blue)))
              `(aw-leading-char-face ((t :inherit bold :height 1.5 :foreground ,red)))
              '(aw-minibuffer-leading-char-face ((t :inherit aw-key-face)))
              '(aw-mode-line-face ((t :inherit bold)))

              ;; avy
              `(avy-background-face ((t :background ,bg-dark :foreground ,fg-dark :extend t)))
              `(avy-goto-char-timer-face ((t :inherit bold :background ,bg-hl)))
              `(avy-lead-face ((t :inherit bold :background ,blue :foreground ,bg)))
              `(avy-lead-face-0 ((t :inherit bold :background ,magenta :foreground ,bg)))
              `(avy-lead-face-1 ((t :background ,dark3)))
              `(avy-lead-face-2 ((t :inherit bold :background ,yellow :foreground ,bg)))

              ;; bookmark
              '(bookmark-face ((t :inherit success)))
              '(bookmark-menu-bookmark ((t :inherit bold)))

              ;; calendar and diary
              '(calendar-month-header ((t :inherit bold)))
              '(calendar-today ((t :inherit bold :underline t)))
              `(calendar-weekday-header ((t :foreground ,cyan)))
              `(calendar-weekend-header ((t :foreground ,red1)))
              `(diary ((t :foreground ,cyan)))
              `(diary-anniversary ((t :foreground ,red1)))
              `(diary-time ((t :foreground ,cyan)))
              `(holiday ((t :foreground ,red1)))

              ;; compilation
              `(compilation-info ((t :inherit bold :foreground ,cyan)))
              `(compilation-warning ((t :inherit bold :foreground ,yellow)))
              `(compilation-error ((t :inherit bold :foreground ,red1)))
              '(compilation-line-number ((t :inherit shadow)))
              '(compilation-column-number ((t :inherit compilation-line-number)))
              '(compilation-mode-line-exit ((t :inherit bold)))
              `(compilation-mode-line-fail ((t :inherit bold :foreground ,red1)))
              `(compilation-mode-line-run ((t :inherit bold :foreground ,yellow)))

              ;; completions
              `(completions-annotations ((t :foreground ,green2 :background unspecified :slant italic)))
              `(completions-common-part ((t :foreground ,blue1 :background unspecified)))
              `(completions-first-difference ((t :foreground ,purple :background unspecified :weight bold)))
              `(completions-highlight ((t :background ,bg-hl :weight bold)))

              ;; corfu
              `(corfu-default ((t :foreground ,fg :background ,bg-dark)))
              `(corfu-current ((t :foreground ,fg :background ,bg-hl :weight bold)))
              `(corfu-bar ((t :background ,fg-dark)))
              `(corfu-border ((t :background ,dark3)))

              ;; custom (M-x customize)
              `(custom-button ((t :background ,bg-dark :foreground ,fg-dark :box(:line-width 1 :color ,fg-dark :style released-button))))
              '(custom-button-mouse ((t :inherit (highlight custom-button))))
              '(custom-button-pressed ((t :inherit (secondary-selection custom-button))))
              `(custom-changed ((t :background ,orange)))
              '(custom-comment ((t :inherit shadow)))
              '(custom-comment-tag ((t :inherit (bold shadow))))
              '(custom-invalid ((t :inherit error :strike-through t)))
              '(custom-modified ((t :inherit custom-changed)))
              '(custom-rogue ((t :inherit custom-invalid)))
              '(custom-set ((t :inherit success)))
              `(custom-state ((t :foreground ,orange)))
              '(custom-themed ((t :inherit custom-changed)))
              '(custom-variable-obsolete ((t :inherit shadow)))
              `(custom-face-tag ((t :inherit bold :foreground ,blue)))
              `(custom-group-tag ((t :inherit bold :foreground ,magenta)))
              `(custom-group-tag-1 ((t :inherit bold :foreground ,orange)))
              `(custom-variable-tag ((t :inherit bold :foreground ,blue2)))

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
              '(diff-error ((t :inherit error)))
              '(diff-file-header ((t :inherit bold)))
              `(diff-function ((t :background ,dark3)))
              '(diff-header (()))
              `(diff-hunk-header ((t :inherit bold :background ,dark3)))
              '(diff-index ((t :slant italic)))
              '(diff-nonexistent ((t :inherit bold)))

              ;; diff-hl
              `(diff-hl-change ((t :foreground ,bg :background ,yellow)))
              `(diff-hl-delete ((t :foreground ,bg :background ,red)))
              `(diff-hl-insert ((t :foreground ,bg :background ,green)))
              `(diff-hl-reverted-hunk-highlight ((t :foreground ,bg :background ,fg)))

              ;; dired
              `(dired-broken-symlink ((t :foreground ,red1 :underline t)))
              `(dired-directory ((t :foreground ,blue)))
              `(dired-flagged ((t :inherit bold :foreground ,blue2 :inverse-video t)))
              '(dired-header ((t :inherit bold)))
              '(dired-ignored ((t :inherit shadow)))
              '(dired-mark ((t :inherit bold)))
              `(dired-marked ((t :inherit bold :foreground ,blue2 :inverse-video t)))
              '(dired-perm-write ((t :inherit shadow)))
              `(dired-symlink ((t :foreground ,cyan :background ,bg :underline ,cyan)))
              '(dired-warning ((t :inherit warning)))

              ;; eglot
              `(eglot-highlight-symbol-face ((t :underline ,dark3)))
              `(eglot-mode-line ((t :foreground ,blue)))
              `(eglot-diagnostic-tag-unnecessary-face ((t :underline (:style wave :color ,cyan))))

              ;; elfeed
              '(elfeed-log-date-face ((t :inherit elfeed-search-date-face)))
              '(elfeed-log-debug-level-face ((t :inherit elfeed-search-filter-face)))
              '(elfeed-log-error-level-face ((t :inherit error)))
              '(elfeed-log-info-level-face ((t :inherit success)))
              '(elfeed-log-warn-level-face ((t :inherit warning)))
              `(elfeed-search-date-face ((t :foreground ,cyan)))
              `(elfeed-search-feed-face ((t :foreground ,purple)))
              '(elfeed-search-filter-face ((t :inherit bold)))
              `(elfeed-search-last-update-face ((t :inherit bold :foreground ,cyan)))
              `(elfeed-search-tag-face ((t :foreground ,blue)))
              `(elfeed-search-title-face ((t :foreground ,fg-dark)))
              '(elfeed-search-unread-count-face (( )))
              `(elfeed-search-unread-title-face ((t :inherit bold :foreground ,fg)))
              `(elfeed-show-header-face ((t :inherit bold)))
              `(elfeed-show-title-face ((t :inherit bold :foreground ,purple)))
              `(elfeed-show-author-face ((t :inherit bold :foreground ,magenta)))
              `(elfeed-show-date-face ((t :foreground ,cyan)))
              `(elfeed-show-feed-face ((t :foreground ,purple)))
              `(elfeed-show-tags-face ((t :foreground ,blue)))

              ;; elisp semantic highlighting
              `(elisp-ampersand ((t :inherit bold :foreground ,blue1)))
              '(elisp-binding-variable (( )))
              `(elisp-bound-variable ((t :foreground ,yellow)))
              '(elisp-charset (( )))
              '(elisp-coding (( )))
              '(elisp-completion-category (( )))
              `(elisp-completion-category-definition ((t :foreground ,orange)))
              `(elisp-condition ((t :inherit bold :foreground ,purple)))
              '(elisp-constant (( )))
              `(elisp-defcharset ((t :foreground ,blue1)))
              `(elisp-defcoding ((t :foreground ,blue1)))
              `(elisp-defface ((t :foreground ,blue1)))
              `(elisp-deficon ((t :foreground ,blue1)))
              `(elisp-defmacro ((t :foreground ,blue)))
              `(elisp-defoclosure ((t :foreground ,blue1)))
              `(elisp-defun ((t :foreground ,blue)))
              `(elisp-defvar ((t :foreground ,yellow)))
              '(elisp-face (( )))
              `(elisp-feature ((t :foreground ,orange)))
              '(elisp-free-variable (( )))
              `(elisp-function ((t :foreground ,blue)))
              `(elisp-function-property-declaration ((t :foreground ,purple)))
              '(elisp-group (( )))
              '(elisp-icon (( )))
              `(elisp-macro ((t :inherit bold :foreground ,magenta)))
              `(elisp-major-mode-name ((t :foreground ,blue1)))
              `(elisp-nnoo-backend ((t :foreground ,blue1)))
              `(elisp-non-local-exit ((t :inherit bold :foreground ,yellow)))
              '(elisp-oclosure (( )))
              `(elisp-rx ((t :inherit bold :foreground ,purple)))
              `(elisp-shadowed-variable ((t :foreground ,yellow)))
              '(elisp-shadowing-variable (( )))
              `(elisp-shorthand-font-lock-face ((t :foreground ,cyan)))
              `(elisp-slot ((t :foreground ,purple)))
              `(elisp-special-form ((t :inherit bold :foreground ,magenta)))
              '(elisp-special-variable-declaration (( )))
              `(elisp-symbol-at-mouse ((t :background ,bg-dark :foreground ,fg)))
              '(elisp-symbol-role (( )))
              `(elisp-symbol-role-definition ((t :foreground ,blue1)))
              '(elisp-theme (( )))
              '(elisp-thing (( )))
              `(elisp-throw-tag ((t :inherit bold :foreground ,fg)))
              '(elisp-type (( )))
              `(elisp-unknown-call ((t :foreground ,blue)))
              `(elisp-variable-at-point ((t :underline ,dark3)))
              `(elisp-warning-type ((t :foreground ,yellow)))
              '(elisp-widget-type (( )))

              ;; eshell
              `(eshell-prompt ((t :foreground ,purple :weight bold)))
              `(eshell-ls-archive ((t :foreground ,red1)))
              '(eshell-ls-backup ((t :inherit font-lock-comment-face)))
              '(eshell-ls-clutter ((t :inherit font-lock-comment-face)))
              `(eshell-ls-directory ((t :foreground ,blue)))
              `(eshell-ls-executable ((t :foreground ,green)))
              '(eshell-ls-missing ((t :inherit font-lock-warning-face)))
              '(eshell-ls-product ((t :inherit font-lock-doc-face)))
              `(eshell-ls-special ((t :foreground ,yellow :weight bold)))
              `(eshell-ls-symlink ((t :foreground ,cyan :weight bold)))
              `(eshell-ls-unreadable ((t :foreground ,fg)))

              ;; flymake
              `(flymake-error ((t :underline (:style wave :color ,red))))
              `(flymake-warning ((t :underline (:style wave :color ,orange))))
              `(flymake-note ((t :underline (:style wave :color ,cyan))))

              ;; flyspell
              `(flyspell-duplicate ((t :underline (:style wave :color ,orange))))
              `(flyspell-incorrect ((t :underline (:style wave :color ,red))))

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
              `(icomplete-first-match ((t :foreground ,blue1 :weight bold)))
              `(icomplete-selected-match ((t :background ,bg-hl :weight bold)))

              ;; ido
              `(ido-first-match ((t :foreground ,blue1 :weight bold)))
              '(ido-incomplete-regexp ((t :inherit error :weight bold)))
              '(ido-indicator ((t :inherit bold)))
              '(ido-only-match ((t :inherit ido-first-match)))
              `(ido-subdir ((t :foreground ,blue1)))
              `(ido-virtual ((t :foreground ,purple)))

              ;; isearch
              `(isearch ((t :foreground ,fg-gutter :background ,yellow)))
              `(isearch-fail ((t :foreground ,fg-gutter :background ,red)))
              `(isearch-group-1 ((t :foreground ,fg-gutter :background ,blue1)))
              `(isearch-group-2 ((t :foreground ,fg-gutter :background ,green1)))
              `(lazy-highlight ((t :foreground ,fg-gutter :background ,cyan)))

              ;; line-number
              `(line-number ((t :inherit default :foreground ,fg-dark)))
              `(line-number-current-line ((t :inherit (bold line-number) :foreground ,fg)))
              `(line-number-major-tick ((t :inherit line-number :foreground ,red)))
              `(line-number-minor-tick ((t :inherit line-number :foreground ,fg-dark)))

              ;; message
              `(message-cited-text-1 ((t :foreground ,blue)))
              `(message-cited-text-2 ((t :foreground ,yellow)))
              `(message-cited-text-3 ((t :foreground ,cyan)))
              `(message-cited-text-4 ((t :foreground ,red)))
              '(message-header-name ((t :inherit bold)))
              '(message-header-newsgroups ((t :inherit message-header-other)))
              `(message-header-to ((t :inherit bold :foreground ,magenta)))
              `(message-header-cc ((t :foreground ,magenta)))
              `(message-header-subject ((t :inherit bold :foreground ,purple)))
              '(message-header-xheader ((t :inherit message-header-other)))
              `(message-header-other ((t :foreground ,purple)))
              `(message-mml ((t :foreground ,blue1)))
              `(message-separator ((t :background ,dark3)))

              ;; mode-line / header-line
              `(mode-line ((t :foreground ,fg :background ,bg-dark1 :box ,bg-dark1)))
              '(mode-line-buffer-id ((t :inherit bold)))
              '(mode-line-active ((t :inherit mode-line)))
              `(mode-line-inactive ((t :foreground ,fg-dark :background ,bg-dark :box ,bg-dark)))
              `(mode-line-emphasis ((t :foreground ,blue)))
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
              `(orderless-match-face-0 ((t :foreground ,blue)))
              `(orderless-match-face-1 ((t :foreground ,purple)))
              `(orderless-match-face-2 ((t :foreground ,teal)))
              `(orderless-match-face-3 ((t :foreground ,red1)))

              ;; org
              `(org-agenda-calendar-daterange ((t :foreground ,fg-dark)))
              `(org-agenda-calendar-event ((t :foreground ,fg-dark)))
              '(org-agenda-calendar-sexp ((t :inherit (bold org-agenda-calendar-event))))
              '(org-agenda-clocking ((t :inherit secondary-selection)))
              `(org-agenda-column-dateline ((t :background ,bg-dark)))
              `(org-agenda-current-time ((t :foreground ,fg)))
              `(org-agenda-date ((t :foreground ,cyan)))
              '(org-agenda-date-today ((t :inherit org-agenda-date :underline t)))
              `(org-agenda-date-weekend ((t :inherit org-agenda-date :foreground ,magenta)))
              `(org-agenda-date-weekend-today ((t :inherit org-agenda-date-today :foreground ,magenta)))
              '(org-agenda-diary ((t :inherit org-agenda-calendar-sexp)))
              '(org-agenda-dimmed-todo-face ((t :inherit shadow)))
              '(org-agenda-done ((t :inherit org-done)))
              `(org-agenda-filter-category ((t :inherit bold :foreground ,red1)))
              `(org-agenda-filter-effort ((t :inherit bold :foreground ,red1)))
              `(org-agenda-filter-regexp ((t :inherit bold :foreground ,red1)))
              `(org-agenda-filter-tags ((t :inherit bold :foreground ,red1)))
              `(org-agenda-restriction-lock ((t :background ,bg-dark :foreground ,fg-dark)))
              `(org-agenda-structure ((t :foreground ,fg-dark)))
              `(org-agenda-structure-filter ((t :inherit org-agenda-structure :foreground ,yellow)))
              '(org-agenda-structure-secondary ((t :inherit font-lock-doc-face)))
              `(org-archived ((t :background ,bg-dark :foreground ,fg)))
              `(org-block ((t :background ,bg-dark :extend t)))
              `(org-block-begin-line ((t :background ,bg-dark :foreground ,fg-dark :extend t)))
              '(org-block-end-line ((t :inherit org-block-begin-line)))
              `(org-checkbox ((t :foreground ,yellow)))
              '(org-checkbox-statistics-done ((t :inherit org-done)))
              '(org-checkbox-statistics-todo ((t :inherit org-todo)))
              '(org-clock-overlay ((t :inherit secondary-selection)))
              `(org-code ((t :background unspecified :foreground ,cyan)))
              `(org-column ((t :inherit default :background ,bg-dark)))
              `(org-column-title ((t :inherit (bold default) :underline t :background ,bg-dark)))
              `(org-date ((t :foreground ,cyan)))
              `(org-date-selected ((t :foreground ,cyan :inverse-video t)))
              `(org-dispatcher-highlight ((t :inherit bold :background ,bg-dark :foreground ,fg)))
              `(org-document-info ((t :foreground ,fg-dark)))
              `(org-document-info-keyword ((t :foreground ,fg-dark)))
              `(org-document-title ((t :foreground ,cyan)))
              `(org-done ((t :foreground ,green)))
              `(org-drawer ((t :foreground ,fg-dark)))
              `(org-ellipsis ((t :foreground ,comment)))
              '(org-footnote ((t :inherit link)))
              `(org-formula ((t :foreground ,magenta)))
              '(org-headline-done ((t :inherit org-done)))
              '(org-headline-todo ((t :inherit org-todo)))
              `(org-hide ((t :foreground ,bg)))
              '(org-indent ((t :inherit (fixed-pitch org-hide))))
              `(org-imminent-deadline ((t :inherit bold :foreground ,red)))
              `(org-latex-and-related ((t :foreground ,cyan)))
              `(org-level-1 ((t :foreground ,fg)))
              `(org-level-2 ((t :foreground ,yellow)))
              `(org-level-3 ((t :foreground ,blue)))
              `(org-level-4 ((t :foreground ,magenta)))
              `(org-level-5 ((t :foreground ,green)))
              `(org-level-6 ((t :foreground ,red)))
              `(org-level-7 ((t :foreground ,cyan)))
              `(org-level-8 ((t :foreground ,fg-dark)))
              '(org-link ((t :inherit link)))
              '(org-list-dt ((t :inherit bold)))
              `(org-macro ((t :foreground ,magenta)))
              `(org-meta-line ((t :foreground ,fg-dark)))
              '(org-mode-line-clock (( )))
              `(org-mode-line-clock-overrun ((t :inherit bold :foreground ,red1)))
              `(org-priority ((t :foreground ,magenta)))
              `(org-property-value ((t :foreground ,fg-dark)))
              '(org-quote ((t :inherit org-block)))
              `(org-scheduled ((t :foreground ,orange)))
              '(org-scheduled-previously ((t :inherit (bold org-scheduled-today))))
              `(org-scheduled-today ((t :foreground ,yellow)))
              `(org-sexp-date ((t :foreground ,cyan)))
              '(org-special-keyword ((t :inherit org-drawer)))
              `(org-table ((t :foreground ,fg-dark)))
              '(org-table-header ((t :inherit (bold org-table))))
              `(org-tag ((t :foreground ,magenta)))
              '(org-tag-group ((t :inherit (bold org-tag))))
              '(org-target ((t :underline t)))
              `(org-time-grid ((t :foreground ,fg-dark)))
              `(org-todo ((t :foreground ,red1)))
              `(org-upcoming-deadline ((t :foreground ,red1)))
              `(org-upcoming-distant-deadline ((t :foreground ,fg)))
              `(org-verbatim ((t :foreground ,magenta)))
              '(org-verse ((t :inherit org-block)))
              '(org-warning ((t :inherit warning)))

              ;; pulse
              `(pulse-highlight-start-face ((t :background ,blue0 :extend t)))

              ;; regexp-builder
              `(reb-match-0 ((t :foreground ,blue1 :background ,bg :inverse-video t)))
              `(reb-match-1 ((t :foreground ,green1 :background ,bg :inverse-video t)))
              `(reb-match-2 ((t :foreground ,red1 :background ,bg :inverse-video t)))
              `(reb-match-3 ((t :foreground ,magenta2 :background ,bg :inverse-video t)))
              '(reb-regexp-grouping-backslash ((t :inherit font-lock-regexp-grouping-backslash)))
              '(reb-regexp-grouping-construct ((t :inherit font-lock-regexp-grouping-construct)))

              ;; ruler-mode
              '(ruler-mode-column-number ((t :inherit ruler-mode-default)))
              `(ruler-mode-comment-column ((t :inherit ruler-mode-default :foreground ,red)))
              `(ruler-mode-current-column ((t :inherit ruler-mode-default :background ,bg-dark :foreground ,fg)))
              `(ruler-mode-default ((t :inherit default :background ,bg-dark :foreground ,fg-dark)))
              `(ruler-mode-fill-column ((t :inherit ruler-mode-default :foreground ,green)))
              `(ruler-mode-fringes ((t :inherit ruler-mode-default :foreground ,cyan)))
              `(ruler-mode-goal-column ((t :inherit ruler-mode-default :foreground ,blue)))
              `(ruler-mode-margins ((t :inherit ruler-mode-default :foreground ,dark3)))
              `(ruler-mode-pad ((t :inherit ruler-mode-default :background ,bg :foreground ,dark5)))
              `(ruler-mode-tab-stop ((t :inherit ruler-mode-default :foreground ,yellow)))

              ;; shell
              '(sh-heredoc ((t :inherit font-lock-string-face)))
              '(sh-quoted-exec ((t :inherit font-lock-builtin-face)))

              ;; show-paren-mode
              `(show-paren-match ((t :background ,blue2 :foreground ,fg-gutter)))
              `(show-paren-match-expression ((t :background ,purple :foreground ,fg-gutter)))
              `(show-paren-mismatch ((t :background ,red1 :foreground ,fg-gutter)))

              ;; speedbar
              '(speedbar-button-face ((t :inherit button)))
              `(speedbar-directory-face ((t :inherit bold :foreground ,blue2)))
              `(speedbar-file-face ((t :foreground ,fg)))
              '(speedbar-highlight-face ((t :inherit highlight)))
              `(speedbar-selected-face ((t :foreground ,cyan :weight bold :inverse-video t)))
              `(speedbar-separator-face ((t :background ,dark3 :foreground ,fg)))
              `(speedbar-tag-face ((t :foreground ,magenta2)))

              ;; tab-bar
              `(tab-bar ((t :background ,bg-dark)))
              `(tab-bar-tab ((t :inherit bold :foreground ,fg :background ,bg)))
              `(tab-bar-tab-group-current ((t :inherit bold :foreground ,fg :background ,bg)))
              `(tab-bar-tab-group-inactive ((t :foreground ,fg-dark :background ,bg-dark)))
              '(tab-bar-tab-highlight ((t :inherit highlight)))
              `(tab-bar-tab-inactive ((t :background ,terminal-black)))
              '(tab-bar-tab-ungrouped ((t :inherit tab-bar-tab-inactive)))

              ;; tab-line
              `(tab-line ((t :background ,bg-dark :height 0.95)))
              `(tab-line-close-highlight ((t :foreground ,red1)))
              '(tab-line-highlight ((t :inherit highlight)))
              '(tab-line-tab (( )))
              `(tab-line-tab-current ((t :inherit bold :background ,bg)))
              `(tab-line-tab-inactive ((t :background ,terminal-black)))
              '(tab-line-tab-inactive-alternate ((t :inherit tab-line-tab-inactive)))
              `(tab-line-tab-modified ((t :foreground ,orange)))

              ;; vertico
              `(vertico-current ((t :background ,bg-hl :weight bold)))

              ;; vundo
              '(vundo-default ((t :inherit shadow)))
              `(vundo-highlight ((t :inherit (bold vundo-node) :foreground ,red)))
              `(vundo-last-saved ((t :inherit (bold vundo-node) :foreground ,blue)))
              `(vundo-saved ((t :inherit vundo-mode :foreground ,blue5)))

              ;; which-func-mode
              `(which-func ((t :inherit bold :foreground ,blue)))

              ;; which-key
              `(which-key-command-description-face ((t :foreground ,fg)))
              `(which-key-group-description-face ((t :foreground ,purple)))
              `(which-key-highlighted-command-face ((t :inherit warning :underline t)))
              `(which-key-key-face ((t :inherit bold :foreground ,blue)))
              `(which-key-local-map-description-face ((t :foreground ,fg)))
              '(which-key-note-face ((t :inherit shadow)))
              '(which-key-separator-face ((t :inherit shadow)))
              '(which-key-special-key-face ((t :inherit error)))

              ;; whitespace-mode
              `(whitespace-big-indent ((t :background ,red1)))
              '(whitespace-empty ((t :background unspecified)))
              `(whitespace-hspace ((t :background unspecified :foreground ,fg-dark)))
              `(whitespace-indentation ((t :background unspecified :foreground ,fg-dark)))
              `(whitespace-line ((t :background unspecified :foreground ,orange)))
              `(whitespace-newline ((t :background unspecified :foreground ,fg-dark)))
              `(whitespace-space ((t :background unspecified :foreground ,fg-dark)))
              '(whitespace-space-after-tab ((t :inherit warning :background unspecified)))
              '(whitespace-space-before-tab ((t :inherit warning :background unspecified)))
              `(whitespace-tab ((t :background unspecified :foreground ,fg-dark)))
              `(whitespace-trailing ((t :background ,red1)))

              ;; widget
              `(widget-button ((t :inherit bold :foreground ,blue1)))
              `(widget-button-pressed ((t :inherit widget-button :foreground ,magenta)))
              '(widget-documentation ((t :inherit font-lock-doc-face)))
              `(widget-field ((t :background ,dark3 :foreground ,fg :extend nil)))
              `(widget-inactive ((t :background ,bg-dark :foreground ,fg-dark)))
              '(widget-single-line-field ((t :inherit widget-field)))

              ;; window-divider-mode
              `(window-divider ((t :foreground ,fg-dark)))
              `(window-divider-first-pixel ((t :foreground ,dark3)))
              `(window-divider-last-pixel ((t :foreground ,dark3))))
             (custom-theme-set-variables
              ',name
              ;;;; ansi-colors
              `(ansi-color-names-vector [,bg ,red ,green ,yellow ,blue ,magenta ,cyan ,fg])
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
