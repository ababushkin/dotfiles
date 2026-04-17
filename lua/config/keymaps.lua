local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Terminal-mode window navigation
map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
map("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- Switch to alternate buffer
map("n", "<Leader><Leader>", "<C-^>")

-- Get off my lawn
for key, hint in pairs({ Left = "h", Down = "j", Up = "k", Right = "l" }) do
  map("n", "<" .. key .. ">", function()
    vim.notify("Use " .. hint, vim.log.levels.WARN)
  end)
end
