# .dotfiles

## Install on a New System
```
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
echo ".dotfiles" >> .gitignore
```

Move the existing dotfiles on the system first if necessary. They will be replaced.

```
git clone --bare https://github.com/Ben-Hampson/.dotfiles.git $HOME/.dotfiles
config checkout
config config --local status.showUntrackedFiles no
```

Now you can commit and push changes:
```
config status
config add .zshrc
config commit -m "Add .zshrc
config push
```

