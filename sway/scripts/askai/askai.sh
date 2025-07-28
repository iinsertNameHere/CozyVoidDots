#!/bin/bash

# Get user input from rofi
content=$(echo "" | rofi -dmenu -p ">" -theme-str 'window { width: 40em; } listview { lines: 0; } entry { placeholder: "Ask AI..."; }')

# Make sure content is not empty
if [ -z "$content" ]; then
  echo "No input provided. Exiting..."
  exit 1
fi


# Start Response Display
rm /tmp/askai-resp.md
kitty --detach --override="font_size 14" ~/.config/sway/scripts/askai/display-resp.sh

# Send the request to OpenRouter API
response=$(curl -s https://openrouter.ai/api/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -d "{
  \"model\": \"deepseek/deepseek-chat-v3-0324:free\",
  \"messages\": [
    {
      \"role\": \"user\",
      \"content\": \"$content\"
    }
  ]
}")

# Extract the AI response from the JSON output (assuming the response structure is something like "choices[0].message.content")
ai_response=$(echo "$response" | jq -r '.choices[0].message.content')

# Display the result in rofi
echo "$ai_response" > /tmp/askai-resp.md