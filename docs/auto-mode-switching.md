# Auto-Mode Switching Investigation

## Current State

Model Matchmaker can auto-switch models (Opus/Sonnet/Haiku) but requires manual mode logging:
```bash
~/.cursor/hooks/log-cursor-mode.sh plan   # Entering Plan mode
~/.cursor/hooks/log-cursor-mode.sh agent  # Back to Agent mode
```

## Proposed Enhancement: Auto-Detect and Auto-Switch Mode

### What We Know

From Cursor keyboard shortcuts (2026):
- **Cmd + .** (Mac) / **Ctrl + .** (Windows): Opens mode selection menu
- **Shift + Tab**: Cycles through modes (Agent → Plan → Ask → Debug)
- Mode is visible in the Cursor UI (button or label in toolbar)

### Technical Feasibility

**Detection:**
- AppleScript can read UI elements from Cursor's toolbar (via Terminal.app proxy with Accessibility permissions)
- Current mode is likely visible as button text or static text element
- Test script: `test-mode-switch.sh` (in this repo)

**Switching:**
- Keyboard automation via `Cmd + .` to open menu
- Arrow keys to navigate to target mode
- Enter to select

### Proposed Workflow

1. **Hook detects mode mismatch**: User asks Opus-level question but is in Plan mode (where Haiku unavailable anyway)
2. **Auto-switch mode**: `Cmd + .` → arrow to Agent mode → Enter
3. **Auto-switch model**: `Cmd + /` → arrow to Opus → Enter
4. **User re-sends**: One Enter keypress, both mode and model are correct

### Benefits

- Eliminates manual mode logging entirely
- Seamless experience: user doesn't think about modes OR models
- Handles edge cases like "Haiku recommended in Plan mode" transparently

### Risks

- More complex keyboard automation (two menus instead of one)
- Mode menu structure might vary between Cursor versions
- Switching modes might reset conversation context (needs testing)

### Next Steps

1. **Test mode detection** via AppleScript (see `test-mode-switch.sh`)
2. **Document mode menu structure** (positions of Agent/Plan/Ask/Debug)
3. **Implement proof-of-concept** mode switcher
4. **Test with real workflows** to verify context preservation
5. **Update model-advisor.sh** to detect and switch modes automatically

### Implementation Notes

Similar to model auto-switch, this would:
- Run via subprocess (survives hook timeout)
- Proxy through Terminal.app (Accessibility permissions)
- Use keyboard shortcuts (robust, version-stable)
- Log attempts for debugging
- Support kill switch for safety

Mode detection could use UI scraping or heuristics:
- If `claude-4.5-haiku` is selected but classifier recommends Opus → likely Agent/Debug/Ask mode
- If hook blocks with "Haiku not available" → definitely Plan mode
- If UI text contains "Plan" → Plan mode active

### Related

- Auto-switch model: Implemented in v2 (#commit-hash)
- Mode logging: `hooks/log-cursor-mode.sh` (current manual approach)
