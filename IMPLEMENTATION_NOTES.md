# IT Crowd Claude - Implementation Notes

## Overview

Complete Claude Code plugin implementation based on The IT Crowd British sitcom. Provides 4 main character personas with 2 additional subagent-only characters for delegation.

## Architecture

### Core Components

1. **Personas** (`plugin/personas/`)
   - 6 character profiles with detailed personality traits, speech patterns, relationships
   - Based on comprehensive IT Crowd wiki research
   - Main: Roy, Moss, Jen, Douglas
   - Subagents: Richmond, Denholm

2. **Hooks** (`plugin/hooks/`)
   - `inject-persona.sh` - UserPromptSubmit hook for main persona injection
   - `inject-subagent-persona.sh` - SubagentStart hook for delegation context
   - `hooks.json` - Hook configuration with regex matcher

3. **Library** (`plugin/lib/`)
   - `persona-manager.sh` - Persona selection, display names, aptitudes
   - `relationships.sh` - Character relationship dynamics for delegation
   - `memory-helpers.sh` - Session state management

4. **Skills** (`plugin/skills/`)
   - `/persona` - Show/switch persona
   - `/persona-list` - List all personas
   - `/persona-random` - Random selection

5. **CLI Tools** (`plugin/bin/`)
   - `select-persona` - Command-line persona management

## Character Research

All personas based on detailed research from https://theitcrowd.fandom.com/wiki/The_IT_Crowd_Wiki

### Main Personas

**Roy Trenneman**
- Lazy but capable IT support
- Catchphrase: "Have you tried turning it off and on again?"
- Avoids work through elaborate schemes
- Irish, pessimistic, bad luck magnet
- Expertise: Systems, web design, video editing

**Maurice Moss**
- Genius-level technical expert
- Emotionally fragile, takes everything literally
- Compulsively honest, socially oblivious
- Catchphrases: "Well, technically speaking...", "Memory IS RAM!"
- Expertise: Hacking, virus removal, circuit design

**Jen Barber**
- Head of IT with zero technical knowledge
- Lied on CV about computer experience
- Compensates with social skills and management speak
- Catchphrase: "Can you explain that in normal English?"
- Expertise: Communication, stakeholder management

**Douglas Reynholm**
- Arrogant, incompetent CEO
- Knows nothing about his tech company
- Crude, forgetful, wastes resources
- Catchphrase: "I'm the boss! I don't need to know how it works!"
- Views employees as disposable

### Subagent Personas

**Richmond Avenal**
- Gothic pessimist turned business executive
- Created "Goth2Boss" transformation methodology
- Theatrical darkness meets strategic thinking
- Expertise: Business transformation, rebranding

**Denholm Reynholm**
- Deceased original CEO
- Built tech empire despite computational illiteracy
- Made grand declarations, understood nothing
- Catchphrase: "I'm declaring war on [problem]!"

## Relationship Dynamics

Implemented comprehensive relationship matrix:

- Roy ↔ Moss: Best friends, Roy exploits Moss's helpfulness
- Roy ↔ Jen: Initially adversarial, romantic tension
- Moss ↔ Jen: Professional, drunken encounter they regret
- Douglas → All: Dismissive, inappropriate, forgets names
- Richmond: Initially exiled, became closer to team
- Denholm: Dismissed IT department, called everyone wrong names

## Technical Implementation

### Hook System

**UserPromptSubmit Flow:**
1. Check `~/.claude/session_persona`
2. If empty, select random from main personas
3. Load persona markdown file
4. Build delegation roster (all personas except current)
5. Inject as system reminder

**SubagentStart Flow:**
1. Parse agent_type from stdin JSON
2. Match against persona regex
3. Load subagent persona file
4. Get main agent's persona from session
5. Inject relationship context
6. Output additional context JSON

### Persona Manager

- Two-tier system: Main personas (random selection) vs subagent-only
- Display name mapping
- User name mapping (how persona addresses user)
- Task aptitude descriptions for delegation roster

### Session State

- File: `~/.claude/session_persona`
- Contains single persona slug (e.g., "moss")
- Persists across Claude Code sessions
- Cleared on plugin uninstall

## Testing Results

✅ Hook injection working correctly
✅ Random persona selection functional
✅ CLI tools working
✅ Session persistence confirmed
✅ Persona switching successful

## Differences from Silicon Valley Claude

1. **Character Count**: 4 main + 2 subagent (vs 6 main + 9 subagent)
2. **Tone**: British IT humor vs Silicon Valley startup culture
3. **Technical Competence Spectrum**:
   - IT Crowd: Moss (genius) → Roy (capable) → Jen/Douglas (incompetent)
   - Silicon Valley: All technically competent to varying degrees
4. **Relationships**: More antagonistic (Douglas, Denholm) vs collaborative
5. **Catchphrases**: More iconic one-liners from IT Crowd

## Future Enhancements

Potential additions:
- More subagent personas (Richmond's boss, April, other Reynholm employees)
- Episode-specific references database (like Silicon Valley references)
- Context-aware catchphrase selection
- Relationship evolution tracking
- IT Crowd universe technical references

## Files Created

```
it-crowd-claude/
├── .claude-plugin/
│   └── marketplace.json
├── plugin/
│   ├── bin/
│   │   └── select-persona
│   ├── hooks/
│   │   ├── hooks.json
│   │   ├── inject-persona.sh
│   │   └── inject-subagent-persona.sh
│   ├── lib/
│   │   ├── memory-helpers.sh
│   │   ├── persona-manager.sh
│   │   └── relationships.sh
│   ├── personas/
│   │   ├── roy.md
│   │   ├── moss.md
│   │   ├── jen.md
│   │   ├── douglas.md
│   │   ├── richmond.md
│   │   └── denholm.md
│   ├── skills/
│   │   ├── persona/
│   │   ├── persona-list/
│   │   └── persona-random/
│   ├── install.sh
│   └── uninstall.sh
├── README.md
├── QUICKSTART.md
├── LICENSE
└── .gitignore
```

Total: 25 files, ~2300 lines

## Installation Command

```bash
claude plugin marketplace add file://~/Code/it-crowd-claude
claude plugin install it-crowd-claude
```

## Character Authenticity

Each persona maintains authentic characteristics:
- Communication style matches show dialogue
- Catchphrases used appropriately
- Technical competence levels respected
- Relationship dynamics preserved
- Humor style consistent with character

**Critical**: Despite persona quirks, all technical work is excellent quality. The incompetent characters (Jen, Douglas) delegate work or frame it appropriately—they don't produce bad code.

## Success Metrics

✅ All personas distinct and recognizable
✅ Delegation system functional with relationship context
✅ Session persistence working
✅ Slash commands operational
✅ Hook system reliable
✅ Character authenticity maintained
✅ Technical excellence preserved despite personas

## Conclusion

Complete, functional IT Crowd persona plugin ready for use. Character research thorough, implementation mirrors Silicon Valley Claude architecture, all systems tested and operational.
