-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.keys.normal_mode["<A-Tab>"] = ":bn<CR>"
lvim.format_on_save = true

vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true

-- Lazy
lvim.plugins = {
  {
    "olimorris/onedarkpro.nvim",
    priority = 100,
  },
}
lvim.colorscheme = "onedark_vivid"
