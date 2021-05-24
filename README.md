# dotfiles

For macOS and Linux(Ubuntu).

## setup

### macOS

- Before execute this command, sign in to App Store.
- You may need to type `sudo xcodebuild -license accept`

```sh
xcode-select --install
```

- put Dock left
- hide Dock icons automatically
- connect HHKB via Bluetooth
- disable Spotlight in "Keyboard shortcuts" in "System Preferences"
- change Alfred's shortcut `command + space`
- change "Define a word"'s shortcut `d`
- make "Key Repeat" and "Delay Until Repeat" fastest and shortest in "System Preferences" respectively
- set up
  - Dropbox
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

### Ubuntu

```sh
sudo apt update && sudo apt upgrade -y && sudo apt install -y curl
```

- manually install

  - [Microsoft Edge](https://www.microsoftedgeinsider.com/en-us/)
  - [Google Chrome](https://www.google.com/chrome/)
  - [Vivado](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html)

    - install the latest version of Vivado
      - download 2020.3 version
      - `chmod +x` the installer
      - execute with `sudo`
        - do not check _installation options_
      - `sudo ln -s /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libtinfo.so.5`
      - `source` `settings64.sh` in `/tools/Xilinx/`
      - Then, you can start `vivado`
    - (refer to [this link](https://danielmangum.com/posts/vivado-2020-x-ubuntu-20-04/))

### Common

```sh
bash -c "$(curl -fsSL raw.github.com/diohabara/dotfiles/master/bin/setup.sh)"
```

- change your shell: `chsh -s $(which zsh)`
- connect GitHub via SSH
  - First follow this link <https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>.
  - After finishing the instructions, execute this command.
  ```sh
  git remote set-url origin git@github.com:diohabara/dotfiles.git
  ```

## Troubleshooting

- If you having difficulty Doom Emacs font rendering, please refer to [this issue](https://github.com/hlissner/doom-emacs/issues/116).
