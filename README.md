# mac-dotfiles

For 🍎. Currently x86-64 only...(´；ω；｀)

## setup

- Before execute this command, sign in to App Store.
- You may need to type `sudo xcodebuild -license accept`

```sh
xcode-select --install
bash -c "$(curl -fsSL raw.github.com/diohabara/mac-dotfiles/master/bin/setup.sh)"
```

- connect GitHub via SSH
  - First follow this link <https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>.
  - After finishing the instructions, execute this command.
  ```sh
  git remote set-url origin git@github.com:diohabara/mac-dotfiles.git
  ```

## Mac

- put Dock left
- remove useless Apps
- hide Dock icons automatically
- connect HHKB via Bluetooth
- disable Spotlight in "Keyboard shortcuts" in "System Preferences"
- turn caps lock key into control key in "Modifier Keys" in "Keyboard" in "System Preferences"
- change Alfred's shortcut `command + space`
- change "Define a word"'s shortcut `d`
- `defaults write -g ApplePressAndHoldEnabled -bool false` to enable key repeat
- make "Key Repeat" and "Delay Until Repeat" fastest and shortest in "System Preferences" respectively
- set up 
  - AltTab
  - Dropbox
    - sign in
  - Backup and Sync
    - sign in
  - Shiftit
    - change keyboard shortcuts
    - disable menu bar icon
  - Spotify
    - sign in
  - Slack
    - sign in to some workspaces
  - Docker
  - Keybase
    - add a new device
  - Google Japanese Input
    - change "Keymap" to "ATOK" in "General"
    - make conversions in "Advanced" halfwidth
  - Visual Studio Code
    - turn on Sync
