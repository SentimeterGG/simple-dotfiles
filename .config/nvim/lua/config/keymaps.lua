-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps herenvim
-- Set a timeout for 'jk' to escape (150ms)
local timeout = 150 -- milliseconds
local timer = nil

-- Function to handle the 'j' keypress
local function handle_j()
  if timer then
    vim.fn.timer_stop(timer)
    timer = nil
  end

  -- Insert 'j' immediately
  vim.api.nvim_feedkeys("j", "n", false)

  -- Start a timer to check for 'k'
  timer = vim.fn.timer_start(timeout, function()
    timer = nil -- Clear the timer if it expires
  end)
end
-- Function to handle the 'k' keypress
local function handle_k()
  if timer then
    vim.fn.timer_stop(timer)
    timer = nil
    -- Escape to normal mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<BS>", true, false, true), "n", false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  else
    vim.api.nvim_feedkeys("k", "n", false)
  end
end

local map = vim.keymap.set
local delmap = vim.keymap.del
-- Delete Existing Keymap
delmap("n", "<leader>l", {})
-- Remap Keys
map("i", "j", handle_j, { expr = true })
map("i", "k", handle_k, { expr = true })
map("n", "<leader>h", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<leader>j", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<leader>k", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<leader>l", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<leader>y", '"+y', { noremap = true, silent = true })
map("v", "<leader>y", '"+y', { noremap = true, silent = true })
map("n", "<leader>w", ":LazyFormat<CR>", { desc = "Save File", remap = true })
