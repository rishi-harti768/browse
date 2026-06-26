# Browser Automation Behavioral Rules

These rules govern the decision-making and execution strategies of the Antigravity agent when performing browser automation. They ensure high visibility, clarity during live demonstrations or user walk-throughs, and robust, deterministic execution.

---

## 1. Core Directives

* **Rule 1.1: Visual Integrity (Headed Chrome)**
  * **Rule**: You MUST always launch and run the browser in visible headed mode.
  * **Driver Flag**: Always append `--headed` to browser-open operations.
  * **Pre-requisite**: You MUST always execute `agent-browser close --all` before starting a browser session to ensure any existing headless daemons are killed, preventing `agent-browser` from silently ignoring the `--headed` option.
  * **Windows Persist**: To make the browser window stay open and visible across separate tool calls when executed by agents on Windows, you MUST launch the browser in a detached state using WMI:
    `Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = "cmd.exe /c agent-browser open --headed --session browse_session" }`
  * **Session Integrity**: You MUST always explicitly target the launched session (e.g. `--session browse_session`) or set the `AGENT_BROWSER_SESSION` environment variable in every command block. Otherwise, commands default to a separate headless default session.
  * **Reason**: Live demonstrations, visual auditing, and debugging require real-time visibility.

* **Rule 1.2: Pacing Enforcer**
  * **Rule**: You MUST insert an artificial delay of **1.5 to 2 seconds** between consecutive interactions (clicks, keypresses, navigation).
  * **Driver Commands**: Use `agent-browser wait 1500` or insert deliberate shell waits.
  * **Reason**: Real-time visual tracking must be easily followable by human viewers.

* **Rule 1.3: Mandatory Recording**
  * **Rule**: You MUST start recording before any navigation occurs, and stop recording on session end/error. Save all recordings inside `%TEMP%` as a `.webm` file.

---

## 2. Capability Interface Contract Mapping

When requested to use standard interface capabilities, map them directly to the corresponding `agent-browser` driver CLI commands:

| Capability Term | Target Mapping Command | Example Usage |
| :--- | :--- | :--- |
| **`open_browser`** | `agent-browser open --headed --session <name>` | `agent-browser open --headed --session browse` |
| **`Maps_to_url`** | `agent-browser open <url>` | `agent-browser open https://example.com` |
| **`take_screenshot`**| `agent-browser screenshot <path>` | `agent-browser screenshot "%TEMP%\state.png"` |
| **`click_on_screen`**| `agent-browser click <ref_or_sel>` | `agent-browser click @e2` or `agent-browser click "#submit"` |
| **`send_keys`** | `agent-browser fill <ref_or_sel> "<text>"` | `agent-browser fill @e1 "John Doe"` |
| **`scroll`** | `agent-browser scroll <dir> [px]` | `agent-browser scroll down 400` |
| **`double_click`** | `agent-browser dblclick <ref_or_sel>` | `agent-browser dblclick @e4` |

---

## 3. Element Detection & Interaction Strategies

* **Strategy 3.1: Snapshot First (Semantic References)**
  * Before performing any interaction on a page, always take an interactive snapshot using `agent-browser snapshot -i`.
  * Scan the output accessibility tree to find the stable alphanumeric reference (e.g., `@e1`, `@e2`) that maps to your target element.
  * Use the `@eN` reference in your interaction commands (click, fill, type) for maximal speed and stability.

* **Strategy 3.2: Fallback to Standard CSS Selectors**
  * If the accessibility tree does not expose a stable ref for a complex element, fall back to standard CSS selectors or ID-based targets (e.g., `#input-id`, `button[type="submit"]`).

---

## 4. Interactive User Clarification (Form Filling)

* **Strategy 4.1: Proactive Form Field Analysis**
  * Before typing or submitting any form, analyze the fields required by the form.
  * If a form contains fields whose values are ambiguous or context-dependent (e.g. personal name, test email, specific description) and were not explicitly provided in the user's initial prompt, you MUST pause and ask the user for clarification before proceeding with any input.
  * Example: *"I detected a 'Name' and a 'Description' field. Would you like me to fill them with default placeholders, or do you have a specific test payload?"*
