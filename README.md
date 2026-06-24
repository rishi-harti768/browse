# Google Antigravity - Browser Automation Plugin (agy-browse)

This repository contains the `browse` plugin for the **Google Antigravity CLI (`agy`)**, designed for intelligent, visual, and highly token-efficient browser automation. 

It satisfies the technical and evaluation criteria of **Assignment 04 - Website Automation Agent** using an AI-first, native-driver architecture.

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
├── CONTEXT.md                 # Domain glossary and ubiquitous language
├── README.md                  # This file (installation & guide)
├── ASSIGNMENT.md              # Original academic assignment spec
├── docs/
│   └── adr/
│       └── 0001-use-agent-browser-as-driver.md  # Decisions record
├── skills/
│   ├── agent-browser/
│   │   └── SKILL.md           # Embedded official agent-browser skill
│   └── browser-grill/
│       └── SKILL.md           # Customized relentless browser grilling skill
└── src/
    └── run-assignment.sh      # Paced headed Chrome script for Assignment 04
```

For detailed architectural justifications and design trade-offs, read [ADR 0001](docs/adr/0001-use-agent-browser-as-driver.md) and [CONTEXT.md](CONTEXT.md).

---

## 🧠 Embedded Agent Skills

When this plugin is installed, two skills become instantly available inside your Antigravity environment:

### 1. `browser-grill` (Interactive Grilling)
A specialized active-reasoning skill that ensures the agent never opens the browser blindly. When triggered by requests like "fill out a form" or "automate browse", it:
- Conducts an interactive, **relentless interview (one question at a time)** to agree on a target URL, input values, and completion criteria.
- Automatically handles prerequisite verification on the developer's system.
- Executes the planned steps in **headed Chrome** with a **2-second pacing delay** between actions and a video recording saved to the OS temp directory.

### 2. `agent-browser` (Official Core)
Enables direct access to `agent-browser`'s 50+ fast CLI commands via direct Chrome DevTools Protocol (CDP).

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