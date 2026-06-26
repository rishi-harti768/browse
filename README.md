# Google Antigravity - Browser Automation Plugin (agy-browse)

This repository is a premium plugin for the **Google Antigravity CLI (`agy`)**, designed for intelligent, visual, and highly token-efficient browser automation. 

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
├── CONTEXT.md                 # Domain glossary and glossary of terms
├── README.md                  # This file (installation & guide)
├── ASSIGNMENT.md              # Original academic assignment spec
├── docs/
│   ├── adr/
│   │   ├── 0001-use-agent-browser-as-driver.md  # Decision: using agent-browser over standard libs
│   │   └── 0002-headed-pacing-recording.md      # Decision: forced headed pacing and recording
│   └── agents/
│       ├── domain.md          # Domain documentation guidelines
│       ├── issue-tracker.md   # Issue tracking guidelines
│       └── triage-labels.md   # Triage label guidelines
├── rules/
│   └── browse-rules.md        # Custom codebase rules enforcing pacing and headed modes
└── skills/
    ├── agent-browser/
    │   └── SKILL.md           # Embedded official agent-browser skill
    └── browse/
        └── SKILL.md           # Customized relentless browser grilling skill (exposes /browse)
```

For detailed architectural justifications and design trade-offs, read [ADR 0001](docs/adr/0001-use-agent-browser-as-driver.md) and [CONTEXT.md](CONTEXT.md).

---

## 💎 Premium Features

### 1. Custom `/browse` Slash Command
By aligning our skill naming with the plugin namespace, typing **`/browse <instruction>`** directly in the Antigravity CLI launches our customized relentless grilling session, walking you through a step-by-step interactive questionnaire to align on a robust, human-watchable automation plan before any browser execution.

### 2. Active Codebase Rule (`rules/browse-rules.md`)
Ensures any future AI agent working in your workspace adheres to your strict quality and visualization criteria (headed Chrome, 1.5s - 2s pacing delays, and automatic OS temp video recording).

### 3. Snapshot-First Reference Interaction
Utilizes the high-efficiency snapshot-and-reference pattern of `agent-browser`. Instead of digesting raw DOMs, the driver analyzes compact accessibility trees to find stable alphanumeric references (e.g. `@e1`, `@e2`) for incredibly fast and reliable form interaction.

---

## 🎯 Running the Assignment 04 Automation

You can run the headed, paced form-filling automation on the Shadcn react-hook-form page directly using the `agent-browser` CLI.

> [!NOTE]
> **Windows Process Cleanup Notice**: When running commands in sequential tool blocks, Windows automatically cleans up the active process tree on completion of each command. To keep the browser window open and active across separate steps, launch it in a detached state using WMI as shown in Step 2.
>
> **Video Recording Note**: Video recording requires `ffmpeg` to be installed. On Windows, you can install it globally via:
> ```powershell
> winget install Gyan.FFmpeg
> ```

```powershell
# 1. Close any stale background daemons to prevent --headed being ignored
agent-browser close --all

# 2. Open headed Chrome session
# On macOS / Linux (standard):
agent-browser open --headed --session browse_session
# On Windows (persistent / detached across separate command blocks):
Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = "cmd.exe /c agent-browser open --headed --session browse_session" }

# 3. Start recording video of the session (saved in your OS temp directory)
# Windows:
agent-browser --session browse_session record start "%TEMP%\browse_session_form.webm"
# Unix/macOS:
agent-browser --session browse_session record start "/tmp/browse_session_form.webm"

# 4. Navigate to the Assignment target page
agent-browser --session browse_session open https://ui.shadcn.com/docs/forms/react-hook-form

# 5. Take an interactive snapshot to get element references
agent-browser --session browse_session snapshot -i

# 6. Fill out form fields using references (with pacing delays)
agent-browser --session browse_session fill @e1 "Antigravity Agent"
agent-browser --session browse_session wait 1500
agent-browser --session browse_session fill @e2 "Automated browser testing using Vercel's agent-browser under Antigravity CLI."
agent-browser --session browse_session wait 1500

# 7. Take confirmation screenshot
# Windows:
agent-browser --session browse_session screenshot "%TEMP%\confirmation.png"
# Unix/macOS:
agent-browser --session browse_session screenshot "/tmp/confirmation.png"

# 8. Stop recording and close the session
agent-browser --session browse_session record stop
agent-browser --session browse_session close
```