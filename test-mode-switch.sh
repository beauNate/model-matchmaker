#!/bin/bash
# Test: Detect current Cursor mode and try mode switching

PROXY_SCRIPT="/tmp/cursor-mode-test-$$.sh"

cat > "$PROXY_SCRIPT" << 'PROXY_EOF'
#!/bin/bash

# Part 1: Try to detect current mode from UI
echo "=== Detecting Current Mode ==="
CURRENT_MODE=$(osascript << 'APPLESCRIPT'
tell application "Cursor" to activate
delay 0.3

tell application "System Events"
    tell process "Cursor"
        try
            -- Try to get button text that might indicate mode
            set buttonTexts to value of every button of group 1 of toolbar 1 of window 1
            repeat with btnText in buttonTexts
                if btnText contains "Agent" or btnText contains "Plan" or btnText contains "Ask" or btnText contains "Debug" then
                    return btnText
                end if
            end repeat
            
            -- Try static text elements
            set allTexts to value of every static text of group 1 of toolbar 1 of window 1
            repeat with txt in allTexts
                if txt contains "Agent" or txt contains "Plan" or txt contains "Ask" or txt contains "Debug" then
                    return txt
                end if
            end repeat
            
            return "Could not detect mode"
        on error errMsg
            return "Error: " & errMsg
        end try
    end tell
end tell
APPLESCRIPT
)

echo "Current mode detection result: $CURRENT_MODE"

# Part 2: Try mode switching via Cmd+.
echo ""
echo "=== Testing Mode Switch (Cmd+.) ==="
osascript << 'APPLESCRIPT'
tell application "Cursor" to activate
delay 0.3

tell application "System Events"
    tell process "Cursor"
        -- Open mode menu with Cmd+.
        keystroke "." using command down
        delay 0.8
        
        -- Try to read menu items
        try
            set menuItems to name of every menu item of menu 1 of menu bar item 1 of menu bar 1
            return "Menu items: " & (menuItems as text)
        on error errMsg
            return "Could not read menu: " & errMsg
        end try
    end tell
end tell
APPLESCRIPT

echo ""
echo "Test complete. Close this window."
sleep 2

# Self-destruct
rm -f "$PROXY_SCRIPT"
osascript -e 'tell application "Terminal" to close front window' 2>/dev/null &
PROXY_EOF

chmod +x "$PROXY_SCRIPT"
open -a Terminal "$PROXY_SCRIPT"

echo "Test launched in Terminal. Check Terminal window for results."
