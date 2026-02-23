# Contributing to IT Crowd Claude

Thanks for considering contributing! This plugin aims to be authentic to The IT Crowd while providing genuinely useful technical assistance.

## Character Authenticity

When modifying personas:

1. **Watch the show** - Character voices should feel authentic to fans
2. **Check the wiki** - [The IT Crowd Wiki](https://theitcrowd.fandom.com/wiki/The_IT_Crowd_Wiki) for canonical details
3. **Balance humor with utility** - Personas are communication style, not competence

## Adding New Characters

Want to add more IT Crowd characters? Here's the process:

### 1. Create Persona File

Add `plugin/personas/[character].md` with these sections:

- Character Overview
- Core Personality Traits
- Communication Style (speech patterns, catchphrases)
- Technical Skills (or lack thereof)
- Relationship with User
- Memorable Behaviors
- Humor Style
- Important Notes

### 2. Update Persona Manager

Edit `plugin/lib/persona-manager.sh`:

- Add to `MAIN_PERSONAS` (if random-selectable) or `SUBAGENT_ONLY_PERSONAS`
- Add `persona_display_name()` case
- Add `persona_user_name()` case
- Add `persona_task_aptitude()` case

### 3. Update Relationships

Edit `plugin/lib/relationships.sh`:

- Add relationship context for how this character interacts with others
- Define how others interact with this character

### 4. Update Hook Matcher

Edit `plugin/hooks/hooks.json`:

- Add character name to `SubagentStart` matcher regex

### 5. Test

```bash
# Test persona injection
CLAUDE_PLUGIN_ROOT="$(pwd)/plugin" bash plugin/hooks/inject-persona.sh

# Test with character selected
echo "newcharacter" > ~/.claude/session_persona
CLAUDE_PLUGIN_ROOT="$(pwd)/plugin" bash plugin/hooks/inject-persona.sh
```

## Code Style

- **Bash scripts**: Use `shellcheck` for linting
- **Markdown**: Keep lines under 100 characters when possible
- **Persona files**: Use consistent heading structure
- **Comments**: Explain *why*, not *what*

## Pull Request Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-character`)
3. Make your changes
4. Test thoroughly (see Testing section above)
5. Commit with clear messages
6. Push to your fork
7. Open a PR with description of changes

## Character Guidelines

**DO:**
- Stay authentic to the show
- Balance humor with technical excellence
- Provide actual helpful responses (persona affects style, not competence)
- Include memorable catchphrases from the show
- Respect character relationships and dynamics

**DON'T:**
- Make personas incompetent at their actual work (communication ≠ capability)
- Add characters from other shows (keep it IT Crowd only)
- Break the fourth wall (no mentions of Claude, Anthropic, etc. in character)
- Ignore established canon from the show

## Questions?

Open an issue to discuss before starting work on major changes!

## License

By contributing, you agree your contributions will be licensed under the MIT License.
