# 🔍 Electron App Detector

A fun, visually appealing script to detect Electron-based applications on your Mac.

## Quick Start

**One-line install and run:**
```bash
curl -sL https://raw.githubusercontent.com/open-saas-directory/awesome-native-macosx-apps/main/detect-electron.sh | bash
```

## What It Does

- 🔎 Scans `/Applications` folder for Electron apps
- ⚡ Identifies apps built with Electron framework
- 📊 Shows app names, sizes, and versions
- 🎨 Beautiful, colorful terminal output
- 💡 Provides recommendations for native alternatives
- 📈 Calculates resource impact

## Example Output

```
╔════════════════════════════════════════════════════════════╗
║  ⚡  Electron App Detector for macOS                       ║
║     Find which apps are secretly Electron-based            ║
╚════════════════════════════════════════════════════════════╝

🔍 Scanning /Applications...

[▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓] Done!

════════════════════════════════════════════════════════════

⚠️  Found 5 Electron app(s) out of 47 total apps

⚡ Electron Apps Detected:

App Name                                 Size         Version
────────────────────────────────────────────────────────────────
Slack                                    165M         4.35.0
Discord                                  156M         0.0.290
Visual Studio Code                       387M         1.85.0
Postman                                  312M         10.20.0
Notion                                   198M         2.2.3

════════════════════════════════════════════════════════════

📦 Resource Impact:

⚠️  High Electron count detected!
   Each Electron app runs a full Chromium browser

════════════════════════════════════════════════════════════

🚀 Want native alternatives?
   Check out: https://github.com/open-saas-directory/awesome-native-macosx-apps

✓ Native apps are:
   • Faster and more responsive
   • Use less RAM and battery
   • Better macOS integration
   • Smaller app size

💡 Fun Fact:
   Electron apps can use 100-300MB RAM even when idle
   Native apps often use less than 50MB

════════════════════════════════════════════════════════════
```

## Manual Installation

**Clone the repository:**
```bash
git clone https://github.com/open-saas-directory/awesome-native-macosx-apps.git
cd awesome-native-macosx-apps
```

**Make executable:**
```bash
chmod +x detect-electron.sh
```

**Run:**
```bash
./detect-electron.sh
```

## How It Works

The script detects Electron apps by checking for:

1. **Electron Framework** - `Electron Framework.framework` in app bundle
2. **Electron Binary** - `Electron` binary in MacOS folder

## Why This Matters

**Electron apps:**
- Run a full Chromium browser for each app
- Use 100-300MB RAM even when idle
- Drain battery faster
- Take longer to launch
- Use more disk space

**Native apps:**
- Use 50MB or less RAM
- Better battery life (2-3x longer)
- Instant launch
- Better macOS integration
- Smaller file sizes

## Native Alternatives

Found Electron apps? Check our curated list of native alternatives.

## Requirements

- Bash shell (default on macOS)
- Apps installed in `/Applications`

## Troubleshooting

**"Permission denied" error:**
```bash
chmod +x detect-electron.sh
```

**Script not finding apps:**
- Ensure apps are in `/Applications` folder
- Some apps in `~/Applications` won't be scanned (by design)

**False negatives:**
- Some apps may hide Electron framework cleverly
- The script uses multiple detection methods to minimize this

## Contributing

Found a bug or have a suggestion? Open an issue or PR!

## License

MIT License - See repository for details

---

**Made with ❤️ for the macOS community**

Check out the full [awesome-native-macosx-apps](https://github.com/open-saas-directory/awesome-native-macosx-apps) list!
