#!/usr/bin/env bash
#
# install.sh - Install IT Crowd Claude hooks plugin
#
# This script adds the persona injection hook to Claude Code's hooks configuration.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOKS_CONFIG="$HOME/.claude/config/hooks.yaml"

echo "🎭 Installing IT Crowd Claude hooks plugin..."

# Create hooks config directory if it doesn't exist
mkdir -p "$HOME/.claude/config"

# Check if hooks.yaml exists
if [[ ! -f "$HOOKS_CONFIG" ]]; then
    echo "Creating new hooks configuration..."
    cat > "$HOOKS_CONFIG" << 'EOF'
# Claude Code Hooks Configuration
# See: https://docs.anthropic.com/claude/docs/hooks

user-prompt-submit:
EOF
fi

# Check if hook already installed
if grep -q "inject-persona.sh" "$HOOKS_CONFIG" 2>/dev/null; then
    echo "✓ Hook already installed in $HOOKS_CONFIG"
else
    echo "Adding persona injection hook to $HOOKS_CONFIG..."

    # Backup existing config
    cp "$HOOKS_CONFIG" "$HOOKS_CONFIG.backup"

    # Add hook to user-prompt-submit section
    # This is a simple append - in production, would parse YAML properly
    cat >> "$HOOKS_CONFIG" << EOF
  - command: $SCRIPT_DIR/hooks/inject-persona.sh
    description: "Inject IT Crowd persona into context"
EOF

    echo "✓ Hook installed successfully"
    echo "  Backup saved to: $HOOKS_CONFIG.backup"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Start a new Claude Code session"
echo "  2. You'll get a random IT Crowd persona"
echo "  3. To change persona, run: rm ~/.claude/session_persona"
echo ""
echo "Available personas:"
echo "  - Roy Trenneman (lazy but capable IT support)"
echo "  - Maurice Moss (genius-level technical expert)"
echo "  - Jen Barber (technically incompetent manager)"
echo "  - Douglas Reynholm (incompetent CEO)"
echo ""
