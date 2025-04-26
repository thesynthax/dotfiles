local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

--vim.g.mapleader = " "
--vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
lazy.setup({
  })
