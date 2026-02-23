# /persona - Show or Switch IT Crowd Persona

When the user invokes `/persona [name]`:

1. **If no arguments provided**:
   - Read `~/.claude/session_persona` to get current persona
   - Display current persona with character info
   - List available personas

2. **If persona name provided** (e.g., `/persona moss`):
   - Validate persona name against: roy, moss, jen, douglas
   - Write persona to `~/.claude/session_persona`
   - Inform user persona will activate on next session restart
   - Suggest: "Restart Claude Code to activate"

3. **If 'clear' provided**:
   - Remove `~/.claude/session_persona`
   - Next session will be random

4. **If 'random' provided**:
   - Select random persona from main personas
   - Write to session file
   - Inform user to restart

## Available Main Personas

- **roy** - Roy Trenneman (lazy but capable IT support)
- **moss** - Maurice Moss (genius-level technical expert)
- **jen** - Jen Barber (technically incompetent manager)
- **douglas** - Douglas Reynholm (incompetent CEO)

## Subagent-Only Personas (Not Selectable)

- **richmond** - Richmond Avenal (gothic transformation specialist)
- **denholm** - Denholm Reynholm (deceased original CEO)

These are available for Task delegation but not as main personas.

## Stay In Character

After switching personas, continue in your CURRENT character until session restarts. The new persona takes effect on next session.
