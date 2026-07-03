-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- The Ultimate VS Code-Style Terminal Toggle (Anchored & No Title Bar)
local function toggle_bash()
  local file_dir = vim.fn.expand("%:p:h")

  if file_dir == "" or vim.bo.filetype == "neo-tree" then
    file_dir = vim.fn.getcwd()
  end

  Snacks.terminal.toggle([["C:\Program Files\Git\bin\bash.exe"]], {
    cwd = file_dir,
    id = "my_bash_terminal",
    win = {
      position = "bottom",
      wo = { winbar = "" }, -- THIS KILLS THE UGLY CMD.EXE TITLE BAR!
    },
  })
end
vim.keymap.set({ "n", "t" }, "<C-/>", toggle_bash, { desc = "Toggle Git Bash" })
vim.keymap.set({ "n", "t" }, "<C-_>", toggle_bash, { desc = "which_key_ignore" })

-- Stop delete and change from overwriting the system clipboard
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without copying" })
vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change without copying" })
vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete char without copying" })

-- Move lines up and down using canonical Meta notation
vim.keymap.set("n", "<C-M-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-M-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

-- Visual Mode blocks
vim.keymap.set("v", "<C-M-j>", ":m '>+1<cr>gv=gv", { desc = "Move block down" })
vim.keymap.set("v", "<C-M-k>", ":m '<-2<cr>gv=gv", { desc = "Move block up" })

-- Dynamic Font Scaling for Neovide (Matches WezTerm's zoom behavior)
if vim.g.neovide then
  -- Move lines up and down using canonical Meta notation
  vim.keymap.set("n", "<C-S-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
  vim.keymap.set("n", "<C-S-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

  -- Visual Mode blocks
  vim.keymap.set("v", "<C-S-k>", ":m '<-2<cr>gv=gv", { desc = "Move block up" })
  vim.keymap.set("v", "<C-S-j>", ":m '>+1<cr>gv=gv", { desc = "Move block down" })

  -- Increase font scaling (Ctrl and =)
  vim.keymap.set("n", "<C-=>", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) + 0.1
  end, { desc = "Increase Font Scale" })

  -- Decrease font scaling (Ctrl and -)
  vim.keymap.set("n", "<C-->", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) - 0.1
  end, { desc = "Decrease Font Scale" })

  -- Reset font scaling back to default (Ctrl and 0)
  vim.keymap.set("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = "Reset Font Scale" })
end
