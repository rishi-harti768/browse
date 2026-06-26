---
name: browse
description: Custom relentless grilling skill for browser automation. Activate when the user asks for any browser automation, web interaction, form filling, scraping, testing, or web navigation task. Enforces a rigorous step-by-step interview to align on a paced, watchable headed Chrome automation plan.
---

# Browser Automation Skill (/browse)

This skill guides the agent through launching and automating browser interactions using the underlying **Driver** (`agent-browser`). It ensures all interactions are visual, human-watchable, robustly recorded, and optimized for live demonstrations, auditing, and visual debugging.

---

## 1. Triggering and Activation

* **Trigger**: `/browse <instruction>`
* **Description**: Initiates a guided web-automation session. When activated, the agent must carefully establish a concrete, step-by-step plan before opening any browser window.

---

## 2. Session Lifecycle & Recording Rules

The agent must rigorously implement the following sequence to guarantee session recording and visible presentation:

### Step 1: Session Initialization
* Always ensure any existing background daemons (which might be running in headless mode) are closed first, preventing the `--headed` flag from being silently ignored:
  ```bash
  agent-browser close --all
  ```
* Initialize the browser session in **Headed Chrome** mode:
  * **Default / macOS / Linux**:
    ```bash
    agent-browser open --headed --session browse_session
    ```
  * **Windows (to persist across separate tool calls/steps)**: Launch in a detached state using WMI so the browser doesn't automatically close on process completion:
    ```powershell
    Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = "cmd.exe /c agent-browser open --headed --session browse_session" }
    ```
* **IMPORTANT**: Always explicitly specify `--session browse_session` or set the `AGENT_BROWSER_SESSION=browse_session` environment variable for all subsequent interaction and screenshot commands to ensure they connect to the correct running headed session.
* Immediately start recording the session. The output video must be a `.webm` file stored in the OS temporary directory (Note: requires `ffmpeg` to be installed on the system):
  * **Windows**: `%TEMP%\browse_session_YYYYMMDD_HHMMSS.webm` (dynamically resolving `%TEMP%`)
  * **Command**:
    ```bash
    agent-browser --session browse_session record start "%TEMP%\browse_session_20260626_160200.webm"
    ```

### Step 2: Human-Centered Pacing
* To ensure the execution is watchable and understandable by human viewers during live presentations or visual audits, apply a **Pacing** delay of **1.5 to 2 seconds** after every single browser operation (e.g. navigation, click, form fill).
* For scripts or commands, insert a wait command:
  ```bash
  agent-browser wait 1500
  ```

### Step 3: Action Execution
* Follow the specific mapping rules defined in [rules/browse-rules.md](file:///C:/workspace/rishi-harti768/browse/rules/browse-rules.md) to run the requested automation steps.

### Step 4: Session Closure & Teardown
* On completion, or if an unexpected error occurs during execution, ensure the recording is cleanly saved and the browser is closed:
  ```bash
  agent-browser record stop
  agent-browser close --all
  ```
* Display a clear, clickable markdown link to the recorded session video in the terminal output:
  ```text
  > [!IMPORTANT]
  > **Browser Automation Session Concluded!**
  >
  > The full recording of this session is successfully saved at:
  > [Watch Session Video](file:///%TEMP%/browse_session_YYYYMMDD_HHMMSS.webm)
  ```

---

## 3. Robust Error Handling

* If an element cannot be found or an interaction times out:
  1. Capture an annotated screenshot immediately:
     ```bash
     agent-browser screenshot error_state.png --annotate
     ```
  2. Stop the session recording cleanly to preserve the captured evidence up to the point of failure.
  3. Close the browser.
  4. Present the error logs, screenshot, and video links clearly to the user.
