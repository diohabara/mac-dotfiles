#!/usr/bin/osascript

-- hide Dock automatically
tell application "System Events" to set the autohide of the dock preferences to true

-- show menu bar
tell application "System Events"
  tell dock preferences to set autohide menu bar to not autohide menu bar
end tell

-- TODO: set capslock to be ctrl

-- TODO: enable three-finger drag

-- TODO: disable Spotlight in "Keyboard shortcuts" in "System Preferences"

-- TODO: make "Key Repeat" and "Delay Until Repeat" fastest and shortest in "System Preferences" respectively
