# My dotfiles

This directory contains the dotfiles for my system

## Links
```
https://www.gnu.org/software/stow/
https://www.youtube.com/watch?v=y6XCebnB9gs
```
## Requirements

Ensure you have the following installed on your system

### Git

```
pacman -S git
```

### Stow

```
sudo apt install  stow

pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```
