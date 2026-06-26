# ADR 0002: Forced Headed Execution with Human-Centered Pacing and Automatic Session Recording

## Context

We are building a browser automation plugin (`browse`) for the Google Antigravity CLI (`agy`) designed to support highly interactive demonstrations, visual debugging, logging, and robust element detection.

Typically, AI agents run browser automation in a headless background mode for speed and efficiency. However, for visual walkthroughs, interactive product audits, or client demonstrations, headless execution is completely invisible, making the automation impossible to trace, follow, or visually verify in real-time.

## Decision

We have decided to force **Headed Chrome** execution, enforce **Human-Centered Pacing**, and enable **Automatic Session Recording** for all browser automation sessions triggered by the plugin.

Specifically:
1.  **Always Headed**: Launch all browser instances with the `--headed` flag.
2.  **Pacing Delay**: Insert an artificial wait of **1.5 to 2 seconds** between every discrete browser interaction command.
3.  **Automatic Video Capturing**: Automatically start video recording (`agent-browser record start`) on browser open and save the session recording in `.webm` format to the OS temporary directory (`%TEMP%`). Stop recording cleanly on exit or error.
4.  **Capability Interface Translation**: Translate high-level capability terms (`open_browser`, `Maps_to_url`, etc.) directly into `agent-browser` CLI equivalents via behavioral instructions stored in `rules/browse-rules.md`.

## Consequences

*   **Pros**:
    *   **Maximum Presentation Clarity**: Viewers can clearly observe the browser window and understand each action as the agent performs it step-by-step.
    *   **Recorded Evidence**: If any technical glitch occurs during a live demonstration or automated test run, a full recorded webm walkthrough is saved in the temporary directory as fallback proof of execution.
    *   **Reduced Friction**: Avoiding a custom MCP server keeps the plugin lightweight, highly portable, and extremely fast to install.
*   **Cons**:
    *   **Performance Overhead**: Introducing pacing delays and visible rendering increases total execution time. This is a deliberate, acceptable trade-off for high-visibility visual auditing and walkthroughs.
