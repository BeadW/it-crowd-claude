# IT Crowd Claude

Give Claude a personality from Channel 4's The IT Crowd. Random persona per session with automatic context injection via hooks. Personas delegate tasks to each other as subagents with full relationship dynamics.

## Installation

```bash
claude plugin marketplace add file://~/Code/it-crowd-claude
claude plugin install it-crowd-claude
```

Done.

## Usage

Start Claude. You'll get one of four main personas:

- **Roy Trenneman** - Lazy but capable IT support, avoids work through elaborate schemes
- **Maurice Moss** - Genius-level technical expert, emotionally sensitive, takes everything literally
- **Jen Barber** - Technically incompetent manager who lied on CV, compensates with social skills
- **Douglas Reynholm** - Arrogant, incompetent CEO who knows nothing about his tech company

Same persona for entire session.

## Subagent Delegation

Each main persona can delegate tasks to **5 other characters** using the Task tool. The delegation roster includes the other 3 main personas plus 2 specialist subagent-only characters:

| Character | Specialty |
|-----------|-----------|
| **Richmond Avenal** | Business transformation, strategic pivots, rebranding, unconventional approaches |
| **Denholm Reynholm** | High-level vision, declaring war on problems, authoritative decisions (no implementation) |

Plus the other main personas (Roy, Moss, Jen, Douglas) depending on who's delegating.

Subagents respond in character with relationship-aware context (e.g., Moss delegated by Roy will be earnestly helpful; Douglas delegated by anyone will be dismissive).

## Choose Your Persona

**Random (default)**: Just start Claude - system picks randomly.

**Slash commands** (inside Claude Code):
```
/persona              # Show current persona
/persona moss         # Switch to Moss
/persona clear        # Clear and go back to random
/persona-list         # List all available personas
/persona-random       # Pick a random persona
```

**CLI** (outside Claude Code):
```bash
plugin/bin/select-persona moss
plugin/bin/select-persona --list
plugin/bin/select-persona --clear
```

## How It Works

- **UserPromptSubmit hook** runs on every prompt, injects full character profile + delegation roster
- **SubagentStart hook** fires when a persona-named subagent launches, injects that character's persona + relationship context with the delegator
- Session state stored in `~/.claude/session_persona`

## Uninstall

```bash
claude plugin uninstall it-crowd-claude
claude plugin marketplace remove it-crowd-claude
```

## License

MIT - Characters from Channel 4's The IT Crowd (parody/educational use)
