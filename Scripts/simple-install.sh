# > This should be installed after cloning my dotfiles repository (to the $HOME folder)
# $ git clone https://github.com/nickgio/dotfiles.git

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install ZSH (ohmyzsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# Install PIP
sudo easy_install pip

# Install Cheat (cheatsheet for Mac interactions)
pip install cheat

# Symlinks -> Where the magic happens
# > Should be accessible in the `dotfiles` repository
# * ✅ zshrc

# Map dotfiles to Home folder
ln -sv "~/dotfiles/zsh/.zshrc" ~

# Install Homebrew Apps & Utilities
source ~/dotfiles/Scripts/Brewfiles

# Install other scripts
source ~/dotfiles/Scripts/macOS.sh
source ~/dotfiles/Scripts/npm.sh

# Set custom iTerm 2 preferences
source ~/dotfiles/iTerm/iterm2.sh

# The following may need to be run after Dropbox installs
# ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌

# Syncs changes made to dotfiles to Dropbox
ln -sv ~/dotfiles ~/Dropbox/Mac
