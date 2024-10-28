# Dotfiles

This repository contains my personal dotfiles for various tools and applications I use to customize my development environment.

## What's Inside

- **lazygit**: Configuration for LazyGit, a simple terminal UI for git commands
- **nvim**: Neovim configuration files
- **skhd**: Simple hotkey daemon for macOS
- **tmux**: Terminal multiplexer configuration
- **wezterm**: Configuration for the WezTerm terminal emulator
- **yabai**: Tiling window manager for macOS
- **zshrc**: Z shell configuration files

## Prerequisites

Before you begin, ensure you have GNU Stow installed:

### macOS

```bash
brew install stow
```

### Linux

```bash
# Ubuntu/Debian
sudo apt-get install stow

# Fedora
sudo dnf install stow

# Arch Linux
sudo pacman -S stow
```

## Installation

1. Clone this repository to your home directory:

```bash
git clone https://github.com/gitfudge0/dotfiles.git ~/.dotfiles
```

2. Navigate to the dotfiles directory:

```bash
cd ~/.dotfiles
```

3. Use stow to symlink all configurations:

```bash
stow */  # This will stow all folders
```

Or selectively install specific configurations:

```bash
stow nvim     # Only install Neovim config
stow tmux     # Only install Tmux config
```

## Uninstalling

To remove the symlinks for a specific configuration:

```bash
stow -D nvim  # Remove Neovim config
```

To remove all symlinks:

```bash
stow -D */    # Remove all configurations
```

## Additional Setup

### Required Dependencies

Make sure you have these applications installed before using their configurations:

- [Neovim](https://neovim.io/)
- [Tmux](https://github.com/tmux/tmux)
- [LazyGit](https://github.com/jesseduffield/lazygit)
- [WezTerm](https://wezfurlong.org/wezterm/)
- [Yabai](https://github.com/koekeishiya/yabai) (macOS only)
- [skhd](https://github.com/koekeishiya/skhd) (macOS only)

## Notes

- These configurations are primarily tested on macOS but should work on most Unix-like systems (except for macOS-specific tools like Yabai and skhd)
- The Yabai and skhd configurations are specifically for macOS window management
- Make sure to backup your existing configurations before installing these dotfiles

## License

This project is open source and available under the MIT License.
