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

## PR Checklist

- [ ] Native (not Electron/web wrapper), in the correct category, alphabetically ordered
- [ ] Icon is real, saved to `resources/icons/`, displayed at 48×48, sourced in `resources/icons/SOURCES.md` (or left text-only)
- [ ] Description is concise and objective; link points to the official site/repo; pricing label is accurate
- [ ] No duplicate entry; clear commit message (e.g. "Add Bear to Note-Taking & Writing")

## Questions?

[Discussions](../../discussions) · [Issues](../../issues/new) · [@mac_native](https://x.com/mac_native) on X

Thanks for contributing! 🙏
