#!/usr/bin/env bash
#
# inject-subagent-persona.sh - Claude Code SubagentStart hook for IT Crowd
#
# Injects persona + relationship context into subagents when they match
# a known IT Crowd persona name. Reads agent_type from stdin JSON.
#
# Hook input (stdin): JSON with agent_type field
# Hook output (stdout): JSON with additionalContext field

set -euo pipefail

# Get plugin root
if [ -n "${CLAUDE_PLUGIN_ROOT:-}" ]; then
    PLUGIN_ROOT="$CLAUDE_PLUGIN_ROOT"
else
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PLUGIN_ROOT="$(dirname "$SCRIPT_DIR")"
fi
PERSONAS_DIR="$PLUGIN_ROOT/personas"

# Source helper libraries
source "$PLUGIN_ROOT/lib/persona-manager.sh"
source "$PLUGIN_ROOT/lib/relationships.sh"

# Known persona-based agent types
PERSONA_AGENTS=("${ALL_PERSONAS[@]}")

# Parse JSON from stdin - try jq first, fall back to python3
parse_agent_type() {
    local input="$1"

    if command -v jq &>/dev/null; then
        echo "$input" | jq -r '.agent_type // empty'
    elif command -v python3 &>/dev/null; then
        echo "$input" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('agent_type',''))"
    else
        echo "" >&2
        echo "Warning: Neither jq nor python3 available for JSON parsing" >&2
    fi
}

# Check if a value is in the persona agents list
is_persona_agent() {
    local agent_type="$1"
    for p in "${PERSONA_AGENTS[@]}"; do
        if [[ "$p" == "$agent_type" ]]; then
            return 0
        fi
    done
    return 1
}

# Build additionalContext for the subagent
build_context() {
    local agent_type="$1"
    local main_persona="$2"

    local persona_file="$PERSONAS_DIR/${agent_type}.md"
    if [[ ! -f "$persona_file" ]]; then
        echo "Warning: Persona file not found: $persona_file" >&2
        return 1
    fi

    local display_name
    display_name=$(persona_display_name "$agent_type")

    local context=""

    # Full persona injection
    context+="# Subagent Persona: ${display_name}

$(cat "$persona_file")

---
"

    # Relationship context (if we know who delegated)
    if [[ -n "$main_persona" ]]; then
        local main_display
        main_display=$(persona_display_name "$main_persona")

        if [[ "$main_persona" == "$agent_type" ]]; then
            # Safety net: same persona as main agent
            context+="
## WARNING: Same Persona Conflict
You have the same persona as the main agent (${display_name}). This should not happen.
Adopt a noticeably different tone or perspective to differentiate yourself. Consider
channeling a secondary aspect of this character that contrasts with the main agent's current approach.

"
        else
            # Normal case: different personas, inject relationship
            context+="
$(get_relationship_context "$main_persona" "$agent_type")

"
        fi
    fi

    context+="
**IMPORTANT**: Stay in character as ${display_name} while maintaining technical excellence. Your persona affects communication style only — never compromise on code quality, accuracy, or thoroughness."

    echo "$context"
}

# Main hook logic
main() {
    # Read stdin JSON
    local input
    input=$(cat)

    # Parse agent_type
    local agent_type
    agent_type=$(parse_agent_type "$input")

    # Only act on persona-based agents
    if [[ -z "$agent_type" ]] || ! is_persona_agent "$agent_type"; then
        # Not a persona agent - output empty JSON (no modifications)
        echo '{}'
        exit 0
    fi

    # Get the main agent's persona (use namespaced session file)
    local main_persona=""
    local session_file="$HOME/.claude/session_persona_it_crowd"
    if [[ -f "$session_file" ]]; then
        main_persona=$(cat "$session_file")
    fi

    # Build the context
    local additional_context
    additional_context=$(build_context "$agent_type" "$main_persona")

    if [[ -z "$additional_context" ]]; then
        echo '{}'
        exit 0
    fi

    # Output JSON with additionalContext
    # Use python3 or jq for safe JSON encoding
    if command -v python3 &>/dev/null; then
        python3 -c "
import json, sys
context = sys.stdin.read()
print(json.dumps({'additionalContext': context}))
" <<< "$additional_context"
    elif command -v jq &>/dev/null; then
        jq -n --arg ctx "$additional_context" '{"additionalContext": $ctx}'
    else
        # Last resort: manual JSON escaping (handles common cases)
        local escaped
        escaped=$(echo "$additional_context" | sed 's/\\/\\\\/g; s/"/\\"/g; s/$/\\n/g' | tr -d '\n' | sed 's/\\n$//')
        echo "{\"additionalContext\": \"${escaped}\"}"
    fi
}

main "$@"
