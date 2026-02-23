#!/usr/bin/env bash
#
# memory-helpers.sh - Interface with Claude Code memory system
#
# These functions interact with Claude's memory system to store/retrieve
# the active persona for the current session.

# Get current session persona from memory
# Returns: persona name (e.g., "jin-yang") or empty string if not found
get_session_persona() {
    # Check if memory file exists for current session
    # Memory is stored in ~/.claude/memory.db (SQLite)
    # For hook scripts, we use a simpler approach: check for temp file

    local session_file="$HOME/.claude/session_persona"

    if [[ -f "$session_file" ]]; then
        cat "$session_file"
    else
        echo ""
    fi
}

# Store persona selection for current session
# Args: $1 = persona name (e.g., "jin-yang")
store_session_persona() {
    local persona="$1"
    local session_file="$HOME/.claude/session_persona"

    echo "$persona" > "$session_file"

    # Also log to stderr for debugging
    echo "✓ Stored session persona: $persona" >&2
}

# Clear session persona (useful for testing)
clear_session_persona() {
    local session_file="$HOME/.claude/session_persona"

    if [[ -f "$session_file" ]]; then
        rm "$session_file"
        echo "✓ Cleared session persona" >&2
    fi
}

# Set specific persona (for manual selection)
# Args: $1 = persona name (e.g., "monica")
# Returns: 0 on success, 1 on invalid persona
set_persona() {
    local persona="$1"
    local session_file="$HOME/.claude/session_persona"

    # Source persona manager to validate persona exists
    source "$(dirname "${BASH_SOURCE[0]}")/persona-manager.sh"

    # Check if persona is valid
    local valid=0
    for p in "${PERSONAS[@]}"; do
        if [[ "$p" == "$persona" ]]; then
            valid=1
            break
        fi
    done

    if [[ $valid -eq 0 ]]; then
        echo "❌ Invalid persona: $persona" >&2
        echo "Available personas:" >&2
        list_personas >&2
        return 1
    fi

    echo "$persona" > "$session_file"
    echo "✓ Set persona to: $(persona_display_name "$persona")" >&2
    return 0
}
