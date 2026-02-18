return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").gdscript.setup({
        cmd = { "nc", "localhost", "6005" },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        gdscript = { "gdformat" },
      },
    },
  },
}
