#!/bin/bash

# Electron App Detector for macOS
# Detects Electron-based applications on your Mac
# Part of: awesome-native-macosx-apps

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Emojis
ELECTRON="⚡"
NATIVE="✨"
SCAN="🔍"
WARN="⚠️"
CHECK="✓"
CROSS="✗"
ROCKET="🚀"
PACKAGE="📦"

# Clear screen and show header
clear
echo ""
echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${ELECTRON}  ${BOLD}${WHITE}Electron App Detector for macOS${NC}${CYAN}               ║${NC}"
echo -e "${CYAN}║${NC}     Find which apps are secretly Electron-based           ${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Function to check if app is Electron
is_electron() {
    local app_path="$1"

    # Check for Electron Framework (most reliable method)
    if [ -d "$app_path/Contents/Frameworks/Electron Framework.framework" ]; then
        return 0
    fi

    return 1
}

# Function to get app size
get_app_size() {
    local app_path="$1"
    du -sh "$app_path" 2>/dev/null | cut -f1
}

# Function to get app version
get_app_version() {
    local app_path="$1"
    defaults read "$app_path/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null || echo "Unknown"
}

# Scan /Applications
echo -e "${SCAN} ${BOLD}Scanning /Applications...${NC}"
echo ""

electron_apps=()
total_apps=0
electron_count=0
total_size=0

# Count total apps first for progress bar
total_app_count=$(find /Applications -maxdepth 2 -name "*.app" 2>/dev/null | wc -l | tr -d ' ')

if [ "$total_app_count" -eq 0 ]; then
    echo -e "${RED}No applications found in /Applications${NC}"
    exit 1
fi

echo -e "${BLUE}Found $total_app_count apps to scan${NC}"
echo ""

# Progress bar variables
current=0
bar_length=50

# Scan applications with real progress
while IFS= read -r -d '' app; do
    ((total_apps++))
    ((current++))

    # Calculate progress percentage
    percent=$((current * 100 / total_app_count))
    filled=$((current * bar_length / total_app_count))

    # Draw progress bar
    printf "\r${BLUE}["
    for ((i=0; i<filled; i++)); do printf "▓"; done
    for ((i=filled; i<bar_length; i++)); do printf "░"; done
    printf "] %3d%% (%d/%d)${NC}" "$percent" "$current" "$total_app_count"

    if is_electron "$app"; then
        app_name=$(basename "$app" .app)
        app_size=$(get_app_size "$app")
        app_version=$(get_app_version "$app")

        electron_apps+=("$app_name|$app_size|$app_version")
        ((electron_count++))
    fi
done < <(find /Applications -maxdepth 2 -name "*.app" -print0 2>/dev/null)

# Clear progress bar line and show completion
printf "\r${BLUE}["
for ((i=0; i<bar_length; i++)); do printf "▓"; done
printf "] ${GREEN}Done!${NC}\n"
echo ""

# Results
echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}"
echo ""

if [ $electron_count -eq 0 ]; then
    echo -e "${GREEN}${CHECK} ${BOLD}Congratulations!${NC}"
    echo -e "${GREEN}No Electron apps detected on your Mac!${NC}"
    echo ""
    echo -e "${NATIVE} Your Mac is running pure native apps! ${NATIVE}"
else
    echo -e "${RED}${WARN} ${BOLD}Found $electron_count Electron app(s) out of $total_apps total apps${NC}"
    echo ""
    echo -e "${YELLOW}${ELECTRON} Electron Apps Detected:${NC}"
    echo ""

    # Table header
    printf "${BOLD}%-40s %-12s %-12s${NC}\n" "App Name" "Size" "Version"
    echo -e "${CYAN}────────────────────────────────────────────────────────────────${NC}"

    # Sort and display apps
    for app_info in "${electron_apps[@]}"; do
        IFS='|' read -r name size version <<< "$app_info"
        printf "${RED}%-40s${NC} ${YELLOW}%-12s${NC} ${PURPLE}%-12s${NC}\n" "$name" "$size" "$version"
    done

    echo ""
    echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}"
    echo ""

    # Calculate total bloat
    echo -e "${PACKAGE} ${BOLD}Resource Impact:${NC}"
    echo ""

    # Memory warning
    if [ $electron_count -ge 5 ]; then
        echo -e "${RED}${WARN} High Electron count detected!${NC}"
        echo -e "   Each Electron app runs a full Chromium browser"
    elif [ $electron_count -ge 3 ]; then
        echo -e "${YELLOW}${WARN} Moderate Electron usage${NC}"
        echo -e "   These apps may impact battery life and performance"
    else
        echo -e "${GREEN}${CHECK} Low Electron usage${NC}"
        echo -e "   Your Mac is mostly running native apps!"
    fi
fi

echo ""
echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}"
echo ""

# Tips
echo -e "${ROCKET} ${BOLD}Want native alternatives?${NC}"
echo -e "   Check out: ${CYAN}https://github.com/open-saas-directory/awesome-native-macosx-apps${NC}"
echo ""
echo -e "${GREEN}${CHECK} Native apps are:${NC}"
echo -e "   • Faster and more responsive"
echo -e "   • Use less RAM and battery"
echo -e "   • Better macOS integration"
echo -e "   • Smaller app size"
echo ""

# Fun fact
if [ $electron_count -gt 0 ]; then
    echo -e "${BLUE}💡 Fun Fact:${NC}"
    echo -e "   Electron apps can use 100-300MB RAM even when idle"
    echo -e "   Native apps often use less than 50MB"
    echo ""
fi

echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}"
echo ""
