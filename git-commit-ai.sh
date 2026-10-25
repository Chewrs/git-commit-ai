#!/usr/bin/env bash
set -euo pipefail

# Configuration
: "${GEMINI_API_KEY:?GEMINI_API_KEY is not set}"
MODEL="${GEMINI_MODEL:-gemini-3.1-flash-lite}"
API_URL="https://generativelanguage.googleapis.com/v1beta/interactions"

# Get staged diff
DIFF=$(git diff --cached --no-ext-diff)
[[ -n "$DIFF" ]] || { echo "No staged changes."; exit 1; }

# Build prompt
PROMPT="Generate a concise Git commit message from the diff.

- Follow Conventional Commits (type(scope): description).
- Describe the actual changes and their purpose.
- Be specific; avoid generic descriptions like 'update README' or 'fix bugs'.
- Use an imperative subject, max 50 characters, without a period.
- Add a body only when necessary; wrap at 72 characters.
- Output only the commit message.

$DIFF"

# Generate message
echo "Generating commit message..."

RESPONSE=$(curl -fsS "$API_URL" \
  -H "x-goog-api-key: $GEMINI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
    --arg model "$MODEL" \
    --arg input "$PROMPT" \
    '{
    model: $model,
    input: $input,
    generation_config: {
      thinking_level: "low",
      thinking_summaries: "none"
    }
  }')")

MESSAGE=$(jq -er '
  [.steps[] | select(.type == "model_output") |
   .content[] | select(.type == "text") | .text] | join("\n")
  | select(length > 0)
' <<< "$RESPONSE")

# Review and commit
TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE"' EXIT

printf '%s\n' "$MESSAGE" > "$TMPFILE"
git commit --edit -F "$TMPFILE"
