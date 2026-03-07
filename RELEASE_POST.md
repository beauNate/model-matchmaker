# Model Matchmaker v2: Auto-Switch

## The Post

We just shipped auto-switch for Model Matchmaker. Here's what that means:

Model Matchmaker blocks you when you're using the wrong model and recommends the right one. Now it **automatically switches the model for you**. No more copying the recommendation, no more manual dropdown clicking.

Press Send → Model Matchmaker blocks → Model switches → Press Enter to re-send.

Terminal flashes for a second, then you're back to work. That's it.

### Why This Matters

1. **Eliminates friction.** The blocker was always there ("switch to Haiku, it's 90% cheaper"). Now it just... switches. One less decision.

2. **The hard part was permissions.** Cursor's subprocess model doesn't have macOS Accessibility permissions. We solved it by proxying through Terminal.app (which does have them) + keyboard automation. It's buried in the code, but it had to be right.

3. **It's optional.** Don't want auto-switch? `toggle-auto-switch.sh off`. You still get the blocking + recommendations.

### How to Enable

```bash
# Grant Accessibility permission first
# System Settings > Privacy & Security > Accessibility > Add Terminal

# Then:
~/.cursor/hooks/toggle-auto-switch.sh on
```

One-liner setup. Works on macOS. That's the release.

### Try It

If you've been using Model Matchmaker and feeling the friction of "block + manual switch + re-send", this removes that last bit. Workflow feels noticeably smoother after the first hour.

It's in the repo now. Update and run.

---

## Channel-Specific Versions

### Twitter/X (280 chars)
```
Model Matchmaker v2: auto-switch is live. 

Recommended the wrong model? It now changes automatically. Terminal flashes, model switches, you keep working.

One `toggle-auto-switch.sh on` to enable. 

50-70% cheaper, 3-5x faster. No friction.

github.com/coyvalyss1/model-matchmaker
```

### LinkedIn (professional tone)
```
Shipped: Model Matchmaker v2 with automatic model switching.

The original problem: Claude Opus is fast and powerful, but it's overkill for git commits and file renames (Haiku handles them identically at 90% less cost).

Model Matchmaker solved it by blocking overpaying workflows and recommending the right model upfront. That reduced friction significantly—but there was still a final step: the manual switch.

v2 eliminates that last step. When we recommend a model switch, the system now does it automatically. Terminal flashes, model changes, you re-send the message.

Result: workflow feels smoother + no cognitive load around model selection.

For anyone running Cursor: toggle it on with one command. Optional, privacy-first (all local), no dependencies.

github.com/coyvalyss1/model-matchmaker
```

### Email / Newsletter
```
Subject: Model Matchmaker v2 — Auto-Switch

Hi,

We just shipped the next version of Model Matchmaker. 

If you've been using it, you know the workflow: you send a message on Opus, Model Matchmaker blocks it and recommends Haiku, you switch models manually, you re-send.

That last manual step is gone now.

When we recommend a model switch, the system does it for you. Terminal flashes for a second, model changes, you press Enter to re-send. 

You can toggle it on with:

```bash
~/.cursor/hooks/toggle-auto-switch.sh on
```

(Requires one Accessibility permission grant in System Settings—takes 30 seconds.)

The hard part wasn't the idea; it was solving the macOS permissions architecture. Cursor's subprocess doesn't have Accessibility access to control UI elements. We solved it by proxying through Terminal.app (which does have it) and using keyboard automation. Solid engineering.

It's optional, local-only, and backward compatible. If you prefer the original "block + recommend" workflow, it still works that way.

Try it. It feels smoother.

Cheers,
Coy
```

### Hacker News / Dev Community
```
Title: Model Matchmaker v2 – Automatic Model Switching for Cursor

Show HN: Model Matchmaker v2 with automatic model switching.

Model Matchmaker is a local Cursor hook that classifies your prompts before sending and recommends the right Claude model (Haiku for git commits, Sonnet for implementation, Opus for architecture).

v2 adds automatic model switching—when we recommend a change, it now switches automatically instead of blocking and asking you to do it manually.

Technical challenge solved: Cursor's subprocess model doesn't have macOS Accessibility permissions. We worked around it by proxying keyboard automation through Terminal.app.

Usage:

```bash
~/.cursor/hooks/toggle-auto-switch.sh on
```

Results from retroactive analysis on my own workflows:
- 50-70% reduction in cloud API spend (same quality, cheaper models)
- 3-5x speed improvement for simple tasks (Haiku responds much faster than Opus)
- Smoother workflow (less context-switching between manual model selection)

The code is in the repo. It's three bash/python files, no dependencies, completely local (no network calls, no telemetry).

Feedback welcome. GitHub link in profile.
```

---

## Key Points to Emphasize

- **Friction elimination** - Auto-switch removes the manual step from the workflow
- **Smart about it** - Still respects your overrides (prefix with `!` to bypass)
- **Optional** - You can turn it off anytime
- **Privacy-first** - All local, no data collection
- **Simple setup** - One command after granting Accessibility permission
- **Solves a real problem** - The permissions architecture complexity is hidden; users just see it "just works"

---

## Distribution Strategy

1. **GitHub** - Release notes in Releases tab
2. **Twitter/X** - Link to release
3. **LinkedIn** - Professional narrative about the workflow improvement
4. **Email** - Personal note to early users
5. **Hacker News** - Technical deep-dive on the permissions solution
6. **Dev Communities** - Cursor subreddit, relevant Discord servers

---
