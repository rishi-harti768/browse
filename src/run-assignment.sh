#!/bin/bash
# run-assignment.sh
# Automates Shadcn react-hook-form filling using agent-browser in headed mode.
# Saves recording to the OS temp directory.

set -euo pipefail

# 1. Environment Verification
echo "🔍 Verifying environment..."
if ! command -v agent-browser &>/dev/null; then
    if ! npx agent-browser@latest --version &>/dev/null; then
        echo "❌ Error: agent-browser is not installed!"
        echo "Please run: npm install -g agent-browser && agent-browser install"
        exit 1
    fi
    AGENT_CMD="npx agent-browser@latest"
else
    AGENT_CMD="agent-browser"
fi

# Determine OS temp directory
TEMP_DIR="${TEMP:-${TMPDIR:-/tmp}}"
TIMESTAMP=$(date +%s)
VIDEO_PATH="$TEMP_DIR/agy-shadcn-form-$TIMESTAMP.webm"
SCREENSHOT_PATH="$TEMP_DIR/agy-shadcn-form-$TIMESTAMP.png"

echo "✅ Environment verified. Using driver: $AGENT_CMD"
echo "📹 Video will be saved to: $VIDEO_PATH"

# 2. Launch Headed Browser
echo "🌐 Launching headed Chrome..."
$AGENT_CMD open "https://ui.shadcn.com/docs/forms/react-hook-form" --headed
$AGENT_CMD wait 5000

# 3. Start Video Recording
echo "🎥 Starting recording..."
$AGENT_CMD record start "$VIDEO_PATH"
$AGENT_CMD wait 2000

# 4. Snapshot Discovery
echo "📸 Discovering interactive elements..."
$AGENT_CMD snapshot -i

# 5. Execute Form Filling with 2-Second Pacing
echo "✍️ Filling 'Username' field..."
$AGENT_CMD find label "Username" fill "Antigravity"
$AGENT_CMD wait 2000

echo "✍️ Filling 'More about you' description textarea..."
$AGENT_CMD find label "More about you" fill "A premium, state-of-the-art browser automation plugin for Antigravity."
$AGENT_CMD wait 2000

echo "💾 Submitting form (Save)..."
$AGENT_CMD find role button click --name "Save"
$AGENT_CMD wait 2000

# 6. Capture Screen Proof
echo "📸 Taking final screenshot..."
$AGENT_CMD screenshot "$SCREENSHOT_PATH"
$AGENT_CMD wait 1000

# 7. Stop Recording & Close Browser
echo "🛑 Stopping recording and closing..."
$AGENT_CMD record stop
$AGENT_CMD close

echo ""
echo "🎉 Automation completed successfully!"
echo "--------------------------------------------------"
echo "📹 WebM Session Video: $VIDEO_PATH"
echo "📸 Final Screenshot:   $SCREENSHOT_PATH"
echo "--------------------------------------------------"
