# put Dock left
defaults write com.apple.Dock orientation -string left
killall Dock

# enable key repeating
defaults write -g ApplePressAndHoldEnabled -bool false

# TODO: switch capslock to be ctrl
