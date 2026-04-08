# Dotfiles

Personal config files managed with a bare git repo.

## What's included

- `.tmux.conf` + `.tmux/scripts/` (tmux config + weather/status scripts)
- `.config/nvim/` (Neovim/LazyVim config, LSP, plugins, keymaps)
- `.vimrc` (vanilla vim fallback)
- `.bashrc` / `.zshrc` (shell config, aliases, PATH)
- `.gitconfig` (delta pager, diff colors)

Plugins are managed by their respective tools (TPM for tmux, lazy.nvim for Neovim) and are not included.

## Setup on a new machine

```bash
# Clone the bare repo
git clone --bare git@github.com:mackhoyle/dotfiles.git ~/.dotfiles

# Checkout files into home directory
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout

# Hide untracked files from status
git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no
```

If checkout conflicts with existing files, back them up first:

```bash
mkdir -p ~/dotfiles-backup
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout 2>&1 \
  | grep "^\t" | awk '{print $1}' \
  | xargs -I{} mv {} ~/dotfiles-backup/{}
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
```

## Install plugins

```bash
# Tmux plugins (TPM)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then press prefix + I inside tmux to install plugins

# Neovim plugins (lazy.nvim installs automatically on first launch)
nvim
```

## Managing dotfiles

Add the alias to your shell (already in .bashrc/.zshrc):

```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

Then use it like normal git:

```bash
dotfiles status
dotfiles add ~/.some-config
dotfiles commit -m "update some-config"
dotfiles push
```

## Dependencies

- [delta](https://github.com/dandavid/delta) - git pager (referenced in .gitconfig)
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder (sourced in shell configs)
- [oh-my-zsh](https://ohmyz.sh/) - zsh framework
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - zsh plugin
