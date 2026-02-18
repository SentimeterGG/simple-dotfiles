return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "accept", "fallback" },
    },
  },
}
