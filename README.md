# .dotfiles

[Source](https://www.atlassian.com/git/tutorials/dotfiles)

## Install on a New System
```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo ".dotfiles" >> .gitignore
```

Move the existing dotfiles on the system first if necessary. They will be replaced.
```
mv .zshrc .zshrc.backup
```

```
git clone --bare https://github.com/Ben-Hampson/.dotfiles.git $HOME/.dotfiles
config checkout
config config --local status.showUntrackedFiles no
```

Run the setup script:
```
./.dotfiles-setup.sh
```

Start a new `zsh` shell to see the changes take effect.

Now you can commit and push changes:
```
config status
config add .zshrc
config commit -m "Add .zshrc"
config push
```

Local `.zshrc` settings go in `.zshrc_local`. This is where sensitive environment variables should go. If the `.zsh_local` is found on the system, it is automatically sourced at the end of `.zshrc`.

## TO DO
- [ ] Script to install zsh plugins, Powerlevel10k, nerd font, and asdf
- [ ] pre-commit: Prevent secrets being committed.
- [ ] Add git config files to keep git aliases
