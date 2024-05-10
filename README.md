
A neovim colorscheme, targetted to high contrast.

# Prerequisites

Neovim 0.8.0+

# Installing

## Using `packer`

```lua
use { "homodeluna/pracale.nvim" }
```

## Using `lazy.nvim`

```lua
{ "homodeluna/pracale.nvim", priority = 1000 , config = true, opts = ...}
```

## Using `vim-plug`

```vim
Plug 'homodeluna/pracale.nvim'
```

# Basic Usage

Inside `init.vim`

```vim
colorscheme pracale
```

Inside `init.lua`

```lua
vim.cmd([[colorscheme pracale]])
```
