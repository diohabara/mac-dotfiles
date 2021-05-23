# put Dock left
defaults write com.apple.Dock orientation -string left
killall Dock

# enable key repeating
defaults write -g ApplePressAndHoldEnabled -bool false

# switch capslock to be ctrl
# Doc: https://stackoverflow.com/questions/22554035/how-to-use-applescript-to-switch-caps-lock-key-to-be-ctrl-key
    tell application "System Events"
tell application "System Preferences"
    reveal anchor "keyboardTab" of pane "com.apple.preference.keyboard"
end tell

tell window 1 of application process "System Preferences"
    click button "Sondertasten …" of tab group 1

    tell sheet 1
        tell pop up button "Feststelltaste (⇪):"

            set state to value
            click
            delay 0.2
            if "Feststelltaste" is in state then
                click menu item "⌃ ctrl-Taste" of menu 1
            else
                click menu item "⇪ Feststelltaste" of menu 1
            end if
            delay 0.2
        end tell
        click button "OK"
    end tell
end tell
    end tell

    if application "System Preferences" is running then
tell application "System Preferences" to quit
    end if
