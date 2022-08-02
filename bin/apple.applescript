#!/usr/bin/osascript

-- hide Dock automatically
tell application "System Events" to set the autohide of the dock preferences to true
-- show menu bar
tell application "System Events"
    tell dock preferences to set autohide menu bar to not autohide menu bar
end tell
-- TODO: switch capslock to be ctrl
