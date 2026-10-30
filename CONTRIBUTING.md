# Contributing to Awesome Native macOS Apps

Thanks for helping improve this list!

## How to Contribute

- **Add an app**: Open a PR using the format below, or an issue with the "App Suggestion" template if you'd rather not do the PR yourself.
- **Fix something**: Typos, broken links, outdated info, or apps that no longer meet the criteria — PRs and issues both welcome.
- **Get a spotlight**: Send your app to [@mac_native](https://x.com/mac_native) on X for a chance at its own post.

## What Qualifies

- ✅ Native — built with Swift, SwiftUI, AppKit, or Objective-C (native web views like WebKit are fine for specific features)
- ✅ Lightweight and fast (typically < 200MB, low resource usage)
- ✅ Follows macOS Human Interface Guidelines, feels native
- ✅ Actively maintained (updated within 2 years), with a stable release
- ❌ Electron apps or web wrappers — no exceptions, including sponsored placements
- ❌ Abandoned projects, malware/adware, poorly designed apps, or self-promoted apps (unless truly exceptional)

## Entry Format

Submit your app **once**, in the English `README.md`. You do not need to translate your listing or edit the localized READMEs. Maintainers handle translation updates. If you prefer an issue, use [Suggest an App](https://github.com/open-saas-directory/awesome-native-macosx-apps/issues/new?template=app-submission.md); suggestions in English, Arabic, Simplified Chinese, Japanese, German, or Spanish are welcome. Include the app name, official URL, category, pricing, a short description, and evidence that it is native.

Each category is an HTML table of icon-led, two-line rows. Add your app as one `<tr>`, in alphabetical order within the category:

```html
<tr>
<td width="64"><img src="resources/icons/app-name.png" width="48" height="48" alt="App Name icon"></td>
<td><strong><a href="https://app-website.com">App Name</a></strong><br><sub>Brief one-line description. <code>Pricing</code></sub></td>
</tr>
```

**Icon**: a real PNG of the app's actual icon — never an emoji, generic symbol, or invented image.

1. Save it to `resources/icons/<app-slug>.png` — extract one automatically with `./scripts/extract-icon.sh <download-url> <app-slug>`.
2. Record its source in `resources/icons/SOURCES.md`.
3. Display it at `width="48" height="48"` regardless of the source file's resolution.

No real icon available? Leave the cell empty (`<td width="64"></td>`) rather than block on it.

**Pricing labels**: `Free`, `Free` `Open Source`, `Freemium`, `Freemium` `Open Source`, `Paid`, `Subscription`, `EU` (team/company based in the EU).

**Description**: one line, under 100 characters, objective (no "best"/"revolutionary"/"you need this"), no emojis.

## New Categories

Open an issue first — explain why it's needed, what apps would go in it, and how it differs from existing categories.

## Translations (for Maintainers and Translators)

No translation API or service is required. When reviewing app changes, ask Codex: "Update all README translations for the current English README, regenerate them, and check that the app listings and links match." Codex updates the translation catalogs; the script below rebuilds the files but does not perform AI translation itself.

English `README.md` is the source of truth for apps, order, links, icons, pricing, and sponsorships. `README.ar.md`, `README.zh-CN.md`, `README.ja.md`, `README.de.md`, and `README.es.md` are generated; do not edit them directly.

1. Review and merge app submissions against the English README. Contributors do not need to edit translation files.
2. Run `python3 scripts/sync-translations.py --report`. New or changed text falls back to English in every translated list, so an app is never omitted while translation is pending.
3. Add or update exact English-text keys in `translations/<locale>.json`. Translate the values only; preserve product names, technical facts, and sponsorship disclosures. Have a fluent speaker review wording, including Arabic reading direction.
4. Run `python3 scripts/sync-translations.py` and commit the catalogs and generated READMEs. Verify with `python3 scripts/sync-translations.py --check --report`.

Each generated README records the English source's SHA-256 fingerprint. The report identifies untranslated text; `--check` detects output that needs rebuilding. These are maintainer checks and do not require app submitters to update all languages. Translations describe the directory; they do not imply that each app supports those languages. The header cards and linked external websites may remain in English.

## PR Checklist

- [ ] Native (not Electron/web wrapper), in the correct category, alphabetically ordered
- [ ] Icon is real, saved to `resources/icons/`, displayed at 48×48, sourced in `resources/icons/SOURCES.md` (or left text-only)
- [ ] Description is concise and objective; link points to the official site/repo; pricing label is accurate
- [ ] No duplicate entry; clear commit message (e.g. "Add Bear to Note-Taking & Writing")

## Questions?

[Discussions](../../discussions) · [Issues](../../issues/new) · [@mac_native](https://x.com/mac_native) on X

Thanks for contributing! 🙏
