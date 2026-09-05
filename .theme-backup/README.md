# Pristine Chirpy theme backup

Snapshot of the upstream jekyll-theme-chirpy files taken immediately before the
2026 dark redesign, so the original look can always be restored.

Contents: `_sass/`, `_layouts/`, `_includes/`, `assets/css/`.

## Restore everything

    cp -R .theme-backup/_sass .theme-backup/_layouts .theme-backup/_includes .
    cp -R .theme-backup/assets/css assets/

## Restore just the look (keeps all other work)

The redesign is additive and lives in only two files:

  * `_sass/variables-hook.scss`  - SCSS variable overrides
  * `_sass/custom/dark-2026.scss` - the design layer

Emptying `_sass/variables-hook.scss` and removing the `@import 'custom/dark-2026'`
line from `assets/css/jekyll-theme-chirpy.scss` returns the site to stock Chirpy.

This directory is dot-prefixed, so Jekyll ignores it and it is never built into
`_site`.
