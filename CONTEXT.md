# Domain Context: Browser Automation Plugin

This document defines the ubiquitous language and domain glossary for the `browse` plugin.

## Glossary

### Plugin (agy-plugin)
A namespaced, installable extension for the Google Antigravity CLI (`agy`) containing `skills/`, rules, and configuration metadata. It is distributed via Git repositories.

### Driver (agent-browser)
Vercel's native Rust browser-automation CLI used as the underlying CDP (Chrome DevTools Protocol) automation engine. It operates on a high-efficiency snapshot-and-reference pattern.

### Grilling Skill (browser-grill)
An active skill within the plugin that governs the interaction loop between the user and the agent. It enforces a relentless, step-by-step interview to build a mutual automation plan before any browser launch.

### Headed Chrome
A visible browser instance launched during automation execution to allow real-time observation, debugging, and live demonstrations.

### Pacing
A deliberate artificial pause introduced between automation actions (clicks, keypresses, navigation) to make the live browser run watchable and understandable by humans.
