#!/usr/bin/env bash
set -euo pipefail

# Configuration
API_KEY="${API_KEY:?API_KEY is not set}"
API_URL="${API_URL:-https://api.openai.com/v1/chat/completions}"
MODEL="${MODEL:-gpt-4o-mini}"

# Get staged changes
DIFF=$(git diff --cached --no-ext-diff)

if [[ -z "$DIFF" ]]; then
  echo "No staged changes. Run git add first."
  exit 1
fi

# Generate request
PROMPT="Write a concise Git commit message for this diff.
- Use Conventional Commits format.
- Subject: max 50 characters.
- Body: optional, wrap at 72 characters.
- Output only the commit message.

$DIFF"

PAYLOAD=$(jq -n \
  --arg model "$MODEL" \
  --arg prompt "$PROMPT" \
  '{
    model: $model,
    messages: [{role: "user", content: $prompt}]
  }')

# Request AI completion
echo "Generating commit message..."

RESPONSE=$(curl -fsS "$API_URL" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD")

MESSAGE=$(jq -er '.choices[0].message.content' <<< "$RESPONSE")

# Review and commit
TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE"' EXIT

printf '%s\n' "$MESSAGE" > "$TMPFILE"
git commit --edit -F "$TMPFILE"

