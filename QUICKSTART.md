# IT Crowd Claude - Quick Start Guide

## What Is This?

A Claude Code plugin that makes Claude embody characters from The IT Crowd TV show. Each session, you get a random persona—Roy (lazy IT support), Moss (genius nerd), Jen (technical incompetent), or Douglas (clueless CEO).

## Installation

```bash
# Add marketplace
claude plugin marketplace add https://github.com/BeadW/it-crowd-claude.git

# Install plugin
claude plugin install it-crowd-claude

# Restart Claude Code
claude
```

That's it. Your next session will have a random IT Crowd persona.

## What You'll See

When you start Claude Code, you'll get one of:

- **Roy Trenneman** - "Have you tried turning it off and on again?" Lazy but capable.
- **Maurice Moss** - "Well, technically speaking..." Genius-level expert, takes everything literally.
- **Jen Barber** - "What kind of operating system?" Doesn't understand IT, great at management speak.
- **Douglas Reynholm** - "I'm the boss!" Incompetent CEO who knows nothing about tech.

The persona affects communication style only—technical work is always excellent.

## Switching Personas

Inside Claude Code:
```
/persona              # Show current persona
/persona moss         # Switch to Moss for next session
/persona-list         # See all options
/persona-random       # Pick random
```

Outside Claude Code:
```bash
cd ~/Code/it-crowd-claude
plugin/bin/select-persona roy
plugin/bin/select-persona --list
```

Changes take effect when you restart Claude Code.

## Delegation

Personas can delegate tasks to each other:

```
Roy: "Moss, can you handle the complex algorithm optimization?"
```

Uses Task tool with `subagent_type: "moss"`. Moss responds in character, knowing Roy delegated.

Available for delegation:
- Roy, Moss, Jen, Douglas (main personas)
- Richmond (gothic business transformation specialist)
- Denholm (deceased CEO, high-level "wisdom")

## Examples

**Roy approach:**
- "Right, what have you done now, mate?"
- Complains about work, delivers solution anyway
- "This is going to take ages" (finishes in 2 minutes)

**Moss approach:**
- "Well, technically speaking, the issue is..."
- Thorough explanations with genuine enthusiasm
- "That's fascinating! Let me show you..."

**Jen approach:**
- "Can you explain that in normal English?"
- Delegates all technical work immediately
- "Great work, team! We really pulled together!"

**Douglas approach:**
- "I don't care! Just fix it!"
- Demands results without understanding
- "These idiots. Computer person, sort it out!"

## Uninstall

```bash
claude plugin uninstall it-crowd-claude
claude plugin marketplace remove it-crowd-claude
```

## Troubleshooting

**Persona not loading?**
- Check `~/.claude/session_persona` exists
- Restart Claude Code
- Plugin hooks enabled in `~/.claude/config/hooks.yaml`

**Want different persona?**
- `/persona clear` then restart (random selection)
- Or pick specific: `/persona moss`

**Stuck with wrong persona?**
```bash
rm ~/.claude/session_persona
```

## Technical Details

- Hooks inject persona on every user prompt
- Subagent hook adds relationship context when delegating
- Session state: `~/.claude/session_persona`
- Persona files: `~/Code/it-crowd-claude/plugin/personas/`

## Have Fun!

The personas are authentic to The IT Crowd characters. Expect:
- Roy's laziness and deflection
- Moss's literal interpretations and emotional sensitivity
- Jen's confident incompetence
- Douglas's crude obliviousness

But all produce excellent technical work—that's the joke.
