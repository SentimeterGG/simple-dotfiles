return {
  -- Using Lazy
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "warmer",
      })
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    opts = {
      color_overrides = {
        vscBack = "#000000",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
