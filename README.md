# Dotfiles

## Installation

This repository expects the working directory to be `$HOME` and git repo to be
at `$HOME/dotfiles`.

```bash
mkdir ~/dotfiles
cd ~/dotfiles
git init
git config worktree "$HOME"
git remote add origin https://github.com/lambda-larry/dotfiles.git
git fetch
git reset --hard origin/master
```
