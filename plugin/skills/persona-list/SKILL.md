---
name: persona-list
description: List all available IT Crowd personas
allowed-tools: Bash
---

# List IT Crowd Personas

Show the user all available IT Crowd personas by running:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/bin/select-persona" --list
```

The output will show:
- Main personas (random selection): roy, moss, jen, douglas
- Subagent-only personas (delegation targets): richmond, denholm

Keep the response short and direct. Mention they can use `/it-crowd-claude:persona <slug>` to select one.
