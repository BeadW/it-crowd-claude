#!/usr/bin/env bash
#
# uninstall.sh - Remove IT Crowd Claude hooks plugin
#
# This script removes the persona injection hook from Claude Code's hooks configuration.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOKS_CONFIG="$HOME/.claude/config/hooks.yaml"
SESSION_FILE="$HOME/.claude/session_persona"

echo "🎭 Uninstalling IT Crowd Claude hooks plugin..."

# Remove session persona file
if [[ -f "$SESSION_FILE" ]]; then
    rm "$SESSION_FILE"
    echo "✓ Removed session persona file"
fi

# Check if hooks config exists
if [[ ! -f "$HOOKS_CONFIG" ]]; then
    echo "✓ No hooks configuration found, nothing to remove"
    exit 0
fi

# Check if our hook is installed
if ! grep -q "inject-persona.sh" "$HOOKS_CONFIG" 2>/dev/null; then
    echo "✓ IT Crowd hook not found in configuration, nothing to remove"
    exit 0
fi

# Backup existing config
cp "$HOOKS_CONFIG" "$HOOKS_CONFIG.backup"
echo "✓ Backed up hooks config to $HOOKS_CONFIG.backup"

# Remove our hook lines
# This is a simple approach - in production would parse YAML properly
sed -i.tmp "/inject-persona.sh/d" "$HOOKS_CONFIG"
sed -i.tmp "/Inject IT Crowd persona/d" "$HOOKS_CONFIG"
rm -f "$HOOKS_CONFIG.tmp"

echo "✓ Removed IT Crowd hook from configuration"
echo ""
echo "✅ Uninstallation complete!"
echo ""
echo "To reinstall, run: $SCRIPT_DIR/install.sh"
echo ""
