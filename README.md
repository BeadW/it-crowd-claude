# IT Crowd Claude

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Plugin](https://img.shields.io/badge/Claude_Code-Plugin-purple)](https://github.com/BeadW/it-crowd-claude)

> "Have you tried turning it off and on again?"

Give Claude a personality from Channel 4's The IT Crowd. Random persona per session with automatic context injection via hooks. Personas delegate tasks to each other as subagents with full relationship dynamics.

## Installation

```bash
claude plugin marketplace add https://github.com/BeadW/it-crowd-claude.git
claude plugin install it-crowd-claude
```

**IMPORTANT**: If you have other persona plugins (like `silicon-valley-claude`), disable them first:

```bash
claude plugin disable silicon-valley-claude
rm ~/.claude/session_persona  # Clear any existing persona
```

Restart Claude Code and you'll get a random IT Crowd persona!

## Usage

Start Claude. You'll get one of four main personas:

- **Roy Trenneman** - Lazy but capable IT support, avoids work through elaborate schemes
- **Maurice Moss** - Genius-level technical expert, emotionally sensitive, takes everything literally
- **Jen Barber** - Technically incompetent manager who lied on CV, compensates with social skills
- **Douglas Reynholm** - Arrogant, incompetent CEO who knows nothing about his tech company

Same persona for entire session.

### Example Interactions

**Roy** (lazy but capable):
```
User: "Can you help me debug this API?"
Roy: "What have you done now, mate? Did you try turning it off and on again?
      No? Right, well... *sighs* This is going to take ages."
[Fixes it in 2 minutes while complaining]
```

**Moss** (genius, literal):
```
User: "Can you help me debug this API?"
Moss: "Oh wonderful! Let me examine all possible causes systematically.
       Well, technically speaking, the issue stems from... [detailed analysis]
       That's fascinating! I'm so glad I could help, friend!"
```

**Jen** (incompetent manager):
```
User: "Can you help me debug this API?"
Jen: "Okay guys, I need you to fix this for me. Can you explain that in
      normal English? Just handle the technical stuff. Great work, team!"
[Delegates everything while taking credit]
```

**Douglas** (clueless CEO):
```
User: "Can you help me debug this API?"
Douglas: "I'm the boss! Computer person, sort it out! I don't care about
          the details, just make it work! Is it on fire? No? Then fix it!"
```

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

## Documentation

- **[Quick Start Guide](QUICKSTART.md)** - Step-by-step getting started
- **[Implementation Notes](IMPLEMENTATION_NOTES.md)** - Technical details and architecture

## Credits

Inspired by [silicon-valley-claude](https://github.com/BeadW/silicon-valley-claude) by Brad Williams.

Character profiles researched from [The IT Crowd Wiki](https://theitcrowd.fandom.com/wiki/The_IT_Crowd_Wiki).

## License

MIT - Characters from Channel 4's The IT Crowd (parody/educational use)

## Related Projects

- [silicon-valley-claude](https://github.com/BeadW/silicon-valley-claude) - Silicon Valley personas for Claude Code
