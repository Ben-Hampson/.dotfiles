# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo apt-get install build-essential
brew install gcc

# zsh plugins
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# FiraCode Nerd Font Light 
unamestr=$(uname)
if [["$unamestr" == "Darwin"]]; then
	# Casks only work on macOS
	brew tap homebrew/cask-fonts
	brew install font-meslo-lg-nerd-font
elif [["$unamestr" == "Linux"]]; then
	wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Light/FiraCodeNerdFont-Light.ttf
	sudo mv FiraCodeNerdFont-Light.ttf /usr/local/share/fonts
	fc-cache -f -v
fi

echo "If this a remote session, you need to install the fonts on the client computer."
echo "Change your terminal emulator's font to 'FiraCode Nerd Font'."
