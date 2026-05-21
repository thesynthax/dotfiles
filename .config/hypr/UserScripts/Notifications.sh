#!/bin/bash
output=$(timeout 3 swaync-client -swb 2>/dev/null)
if [ $? -ne 0 ] || [ -z "$output" ]; then
  echo '{"text":" 0", "alt":"none", "tooltip":"0 notifications", "class":"none"}'
  exit 0
fi

state=$(echo "$output" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('class',''))" 2>/dev/null)
count=$(echo "$output" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('text','0'))" 2>/dev/null)

case "$state" in
  notification) icon="" ;;
  dnd-none|dnd-notification|dnd-inhibited-notification|dnd-inhibited-none) icon="" ;;
  *) icon="" ;;
esac

echo "{\"text\":\"$icon $count\", \"alt\":\"$state\", \"tooltip\":\"$count notifications\", \"class\":\"$state\"}"
