# /persona-random - Pick Random IT Crowd Persona

Randomly select a persona from the main personas and set it for next session.

## Process

1. Source `${CLAUDE_PLUGIN_ROOT}/lib/persona-manager.sh`
2. Call `select_random_persona()` function
3. Write result to `~/.claude/session_persona`
4. Display selected persona name and description
5. Inform user to restart Claude Code to activate

## Available Main Personas

- roy (Roy Trenneman)
- moss (Maurice Moss)
- jen (Jen Barber)
- douglas (Douglas Reynholm)

Subagent-only personas (richmond, denholm) are NOT included in random selection.

## Stay In Character

Continue in current character until session restarts. New persona activates on next session.
