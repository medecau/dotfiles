# dotfiles

Oh hay!

These are dotfiles - configuration files for the shell, ssh, etc.
The files are shared here so friends and colleagues take ideas or suggest changes. keep me from adding silly stuff to the files like access tokens, and to make it easier to setup new machines.

## Bootstrap a new machine

### 1. Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. Install 1Password

Install 1Password and sign in. Enable the SSH agent in 1Password Settings > Developer > SSH Agent.

### 3. Link the 1Password SSH agent

The dotfiles expect the agent socket at `~/.ssh/agent.sock`. Create a hard link to the 1Password agent socket:

```sh
mkdir -p ~/.ssh
ln ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.ssh/agent.sock
```

### 4. Clone dotfiles

```sh
git clone --bare https://github.com/medecau/dotfiles.git ~/.git.dfs
```

### 5. Checkout the dotfiles

```sh
git --git-dir ~/.git.dfs --work-tree ~ checkout
```

This may fail if existing files conflict. Back up or remove the conflicting files and retry.

### 6. Switch remote to SSH

The clone uses HTTPS but we need SSH for pushing:

```sh
git --git-dir ~/.git.dfs --work-tree ~ remote set-url origin git@github.com:medecau/dotfiles.git
```

### 7. Source the shell config

```sh
source ~/.zshrc
```

This loads everything under `~/.zshrc.d/` and starts tmux.

### 8. Install packages

```sh
brew bundle --file=~/Brewfile
brew bundle --file=~/Brewfile.ws  # workstation-specific packages
```
