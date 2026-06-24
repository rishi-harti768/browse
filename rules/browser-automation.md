# Browser Automation Guidelines

Always follow these engineering constraints and guidelines when executing browser automation or web tasks within this workspace:

## 1. Engine & Driver
- Use Vercel's native Rust-based **`agent-browser`** CLI directly (do NOT use Playwright or Puppeteer node packages directly unless explicitly requested).
- If the binary is missing, alert the user to run `npm install -g agent-browser && agent-browser install`.

## 2. Interactive Grill Interview
- Before initializing any browser window, always activate and run the **`/browse`** skill command first.
- Walk the user through a relentless, step-by-step interview (**one question at a time**) to construct a shared target plan.

## 3. Headed Visualization & Pacing
- Always launch Chromium with the **`--headed`** flag so the live run is fully visible and observable.
- Introduce an artificial **2-second pacing delay** (`agent-browser wait 2000`) before and after every form fill, keypress, or click event to ensure the visual run is watchable by human evaluators.

## 4. Video Recording and Evidence
- Initialize video recording before starting the automation workflow:
  - On Windows: Save to `%TEMP%\agy-browse-<timestamp>.webm`
  - On Unix/macOS: Save to `/tmp/agy-browse-<timestamp>.webm`
- Capture step-by-step screenshots for evidence of successful execution.
- Ensure the recording is cleanly stopped with `agent-browser record stop` on completion or failure.
