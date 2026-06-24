---
name: browse
description: Custom relentless grilling skill for browser automation. Activate when the user asks for any browser automation, web interaction, form filling, scraping, testing, or web navigation task. Enforces a rigorous step-by-step interview to align on a paced, watchable headed Chrome automation plan.
allowed-tools: Bash(agent-browser:*), Bash(npx agent-browser:*)
---

# browse

This skill governs how AI agents interact with users for browser automation tasks under the `browse` plugin. It forces the agent to align on a precise plan through an interactive, relentless interview before launching headed Chrome.

## 1. Environment Verification

Before starting the interview, verify if `agent-browser` is available on the host machine:

```bash
agent-browser --version
```

If the command fails or if Chromium is not downloaded, halt and present this helper block to the user:

```text
⚠️ agent-browser is missing or not fully initialized!
Please run the following commands in your shell to configure it:
  npm install -g agent-browser
  agent-browser install
```

## 2. Relentless Interview Protocol

Never execute any browser command immediately. Conduct a relentless interview about every aspect of the automation.
*   **One Question at a Time**: You must ask only **one question at a time**, waiting for user feedback before asking the next. Asking multiple questions is bewildering.
*   **Walk the Design Tree**:
    1.  **Target URL**: Ask for the starting web page address.
    2.  **Fields & Interactions**: Ask for the exact fields to populate (inputs, textareas), elements to click, or options to select, along with their values.
    3.  **Completion Criteria**: Ask how the agent will verify that the task succeeded (e.g., success message, redirected URL, or element state change).
    4.  **Confirm Visualization**: Inform the user that the browser will run in **headed Chrome** with a **2-second pacing delay** between commands, and a video recording will be saved to their **OS temp directory** (`%TEMP%` on Windows, `/tmp` on Unix/macOS) as `agy-browse-<timestamp>.webm`.
*   **Recommend Answers**: For every question you ask, provide your recommended answer to keep the momentum fast.

## 3. Headed Chrome Execution Protocol

Once the plan is mutually agreed upon, drive `agent-browser` using the following exact execution guidelines:

1.  **Launch Headed Chrome**:
    Always append the `--headed` flag:
    ```bash
    agent-browser open "<URL>" --headed
    ```

2.  **Start Recording**:
    Save the video session to the OS temp directory:
    -   *Windows*: `agent-browser record start "%TEMP%\agy-browse-<timestamp>.webm"`
    -   *Unix/macOS*: `agent-browser record start "/tmp/agy-browse-<timestamp>.webm"`

3.  **Snapshot Discovery**:
    Run `agent-browser snapshot -i` to capture the accessibility tree and interactive element refs (`@e1`, `@e2`, etc.).

4.  **Action Pacing (2-Second Delay)**:
    Introduce a 2-second visual delay before and after every interaction so the user can easily watch the screen:
    ```bash
    agent-browser wait 2000
    ```

5.  **Interact**:
    Execute actions using references:
    ```bash
    agent-browser fill @e1 "Value"
    agent-browser wait 2000
    agent-browser click @e2
    ```

6.  **Take Evidence Screenshots**:
    Capture screenshots at key milestones:
    ```bash
    agent-browser screenshot "%TEMP%\agy-browse-<timestamp>-step.png"
    ```

7.  **Stop and Conclude**:
    ```bash
    agent-browser record stop
    agent-browser close
    ```
    Print the exact file paths of the recorded video and screenshots so the user can easily review them.

## 4. Shortcut: Academic Assignment 04 (Shadcn Form)

If the user mentions "Shadcn", "Assignment 04", "react-hook-form", or "academic form", trigger the quick-start path:
-   **URL**: `https://ui.shadcn.com/docs/forms/react-hook-form`
-   **Form Fields**: Name (username input field) and Description (description textarea).
-   **Values**: Pre-propose standard dummy values (e.g., Name: `Antigravity`, Description: `A powerful agent-first browser automation plugin.`) and ask for immediate confirmation to run.
