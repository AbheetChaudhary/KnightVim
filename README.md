# KnightVim

I used to spend all my time either in the BatCave or in the terminal, making and breaking my linux config. Very soon I realised that Vim is my archnemesis.
This repo is me going deeper into the depths of the rabit hole called Vim.<br />
I think I'm destined to do this forever....

## Setup

Before trying this config make sure to remove or move your current `nvim` directory

**IMPORTANT** Requires [Neovim v0.8.0](https://github.com/neovim/neovim/releases).  [Upgrade](#upgrade-to-latest-release) if you're on an earlier version. 
```
git clone https://github.com/abheetChaudhary/KnightVim.git ~/.config/nvim
```
`main` branch is like a stable release,  it will be updated atmost once or twice a month. Checkout to `TestBranch` if you want more up-to-date config. I will be frequently updating `TestBranch` as I learn more about plugins and other nvim stuff

Run `nvim` and wait for the plugins to be installed,  or manually initiate the installation by running `:PackerSync`.

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim) 


## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On Ubuntu

  ```
  sudo apt install xsel
  ```

- On Arch Linux

  ```
  sudo pacman -S xsel
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```
  pip install pynvim
  ```

- Neovim node support

  ```
  npm i -g neovim
  ```
---

**NOTE**: make sure you have `git`, `make`, `pip`, `npm`, `node` and `cargo` installed on your system.

This config is heavily inspired and sometimes downright copied from [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch).

