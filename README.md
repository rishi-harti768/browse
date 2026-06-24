# Google Antigravity - Browser Automation Plugin (agy-browse)

This repository is a world-class, premium plugin for the **Google Antigravity CLI (`agy`)**, designed for intelligent, visual, and highly token-efficient browser automation. 

It satisfies and exceeds the criteria of **Assignment 04 - Website Automation Agent** using an AI-native, direct-driver architecture.

---

## 🚀 Installation

Install this plugin globally into your Antigravity CLI:
```bash
agy plugin install https://github.com/rishi-harti768/browse
```

### Prerequisites
This plugin uses Vercel's native Rust browser-automation driver under the hood. Ensure you have it installed and initialized:
```bash
npm install -g agent-browser
agent-browser install
```

---

## 📂 Plugin Architecture & Directory Structure

```text
browse/
├── plugin.json                # Plugin package descriptor
├── mcp_config.json            # Registers agent-browser as a native MCP tool server
├── hooks.json                 # Lifecycle hook for clean process termination on Stop
├── CONTEXT.md                 # Domain glossary and ubiquitous language
├── README.md                  # This file (installation & guide)
├── ASSIGNMENT.md              # Original academic assignment spec
├── docs/
│   └── adr/
│       └── 0001-use-agent-browser-as-driver.md  # Decisions record
├── rules/
│   └── browser-automation.md  # Custom codebase rules enforcing pacing and headed modes
├── skills/
│   ├── agent-browser/
│   │   └── SKILL.md           # Embedded official agent-browser skill
│   └── browse/
│       └── SKILL.md           # Customized relentless browser grilling skill (exposes /browse)
└── src/
    └── run-assignment.sh      # Paced headed Chrome script for Assignment 04
```

For detailed architectural justifications and design trade-offs, read [ADR 0001](docs/adr/0001-use-agent-browser-as-driver.md) and [CONTEXT.md](CONTEXT.md).

---

## 💎 Premium Features

### 1. Custom `/browse` Slash Command
By aligning our skill naming with the plugin namespace, typing **`/browse`** directly in the Antigravity CLI launches our customized relentless grilling session, walking you through a step-by-step interactive questionnaire before any browser execution.

### 2. Native MCP Tool Server (`mcp_config.json`)
The plugin automatically exposes `agent-browser`'s native commands as Model Context Protocol (MCP) tools. This allows any AI assistant to interact with browser windows natively via structured JSON-RPC calls rather than executing arbitrary bash shell commands.

### 3. Session Cleanup Hook (`hooks.json`)
On the event of an agent execution stoppage or error, the plugin triggers a pre-configured lifecycle `Stop` hook that executes `agent-browser close` to instantly clean up and close any orphaned background Chrome windows.

### 4. Active Codebase Rule (`rules/browser-automation.md`)
Ensures any future AI agent working in your workspace adheres to your strict quality and visualization criteria (e.g. headed Chrome, 2-second pacing delays, and OS temp video recording).

---

## 🎯 Running the Assignment 04 Automation

To run the headed, paced form-filling automation on the Shadcn react-hook-form page, run our reference bash script:

```bash
bash src/run-assignment.sh
```

### What happens during the run:
1.  Verifies the presence of `agent-browser`.
2.  Launches a visible (**headed**) instance of Google Chrome.
3.  Initializes a video recording saved to your OS temporary directory:
    -   *Windows*: `%TEMP%\agy-shadcn-form-<timestamp>.webm`
    -   *Unix/macOS*: `/tmp/agy-shadcn-form-<timestamp>.webm`
4.  Navigates to `https://ui.shadcn.com/docs/forms/react-hook-form`.
5.  Fills out the **Username** and **More about you (Description)** fields using semantic labels.
6.  Triggers a **2-second pacing delay** between key actions so you and your examiners can watch the visual inputs in real-time.
7.  Saves a final confirmation screenshot to your OS temporary folder.
8.  Stops the recording, terminates the browser session, and outputs the exact video file path.